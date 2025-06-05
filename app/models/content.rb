  require "erb"


class Content < ApplicationRecord
  belongs_to :user
  has_many :content_tags
  has_many :tags, through: :content_tags
  has_many :questions
  has_many :notes

  #after_commit :generate_ai_tags_later, on: [:create]

  def generate_question
    return nil unless transcription.present?
    QuestionGeneratorService.new(transcription).call
  end


  class Content < ApplicationRecord
    belongs_to :user
    has_many :content_tags
    has_many :tags, through: :content_tags
    has_many :questions
    has_many :notes

    def generate_question
      return nil unless transcription.present?
      QuestionGeneratorService.new(transcription).call
    end

    def get_transcript!
      api_url = "https://api.supadata.ai/v1/youtube/transcript?url=#{ERB::Util.url_encode(url)}&lang=en"
      response = HTTParty.get(
        api_url,
        headers: {
          'x-api-key' => ENV['SUPADATA_API_KEY'],
          'Content-Type' => 'application/json'
        }
      )

      response = JSON.parse(response.body)
      if response.nil? || response["content"].nil? || response["lang"].nil?
        raise "Failed to fetch transcript or language from API"
      else
        update!(
          transcription: response["content"],
          language: response["lang"]
        )
      end
    end

    def enrich!
      api_url = "https://api.supadata.ai/v1/youtube/video?id=#{ERB::Util.url_encode(url)}"
      response = HTTParty.get(
        api_url,
        headers: {
          'x-api-key' => ENV['SUPADATA_API_KEY'],
          'Content-Type' => 'application/json'
        }
      )
      response = JSON.parse(response.body)
      if response.nil? || response["title"].nil? || response["duration"].nil? || response["thumbnail"].nil?
        raise "Failed to fetch video details from API"
      else
        update!(
          name: response["title"],
          duration: response["duration"],
          thumbnail: response["thumbnail"]
        )
      end
    end


    def summarize!
      if transcription.blank?
        Rails.logger.warn("No transcription available for summarization.")
      else
        summarizer = ContentSummarizer.new(transcription: transcription)
        summary = summarizer.call
        update!(summary: summary) if summary.present?
      end
    end

  def generate_ai_tags_later
    GenerateTagsJob.perform_later(self)

  end
end
