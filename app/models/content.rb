  require "erb"

  class Content < ApplicationRecord
    belongs_to :user
    has_many :content_tags
    has_many :tags, through: :content_tags
    has_many :questions
    has_many :notes

    # after_commit :generate_stuff_content, on: [:create]

    def generate_questions
      QuestionGeneratorService.new(self.transcription).call
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
      Rails.logger.info("Generated summary: #{summary}")
      update!(summary: summary) if summary.present?
    end

    def self.search_by_name_and_tags(query)
      query = "%#{query.downcase}%"

      left_joins(:tags)
        .where("LOWER(contents.name) LIKE :q OR LOWER(tags.name) LIKE :q", q: query)
        .distinct
    end
  end
end
