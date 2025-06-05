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

  update(
    transcription: response["content"],
    language: response["lang"]
  )
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
    response =JSON.parse(response.body)
    update!(
      name: response["title"],
      duration: response["duration"],
      thumbnail: response["thumbnail"])
  end

  def summarize!
    summarizer = ContentSummarizer.new(transcription: transcription)
    summary = summarizer.call
    update(summary: summary) if summary.present?
  end

  def generate_ai_tags_later
    GenerateTagsJob.perform_later(self)
  end

  def self.search_by_name_and_tags(query)
    query = "%#{query.downcase}%"

    left_joins(:tags)
      .where("LOWER(contents.name) LIKE :q OR LOWER(tags.name) LIKE :q", q: query)
      .distinct
  end
end
