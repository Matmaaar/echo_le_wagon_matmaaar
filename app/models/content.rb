  require "erb"
class Content < ApplicationRecord
  belongs_to :user
  has_many :content_tags
  has_many :tags, through: :content_tags
  has_many :questions
  has_many :notes

  def generate_question
    QuestionGeneratorService.new(self).call
  end


 def get_transcript
  api_url = "https://api.supadata.ai/v1/youtube/transcript?url=#{ERB::Util.url_encode(url)}&lang=en"
  response = HTTParty.get(
    api_url,
    headers: {
      'x-api-key' => ENV['SUPADATA_API_KEY'],
      'Content-Type' => 'application/json'
    }
  )

  # Force l'encodage en UTF-8
  raw_body = response.body.force_encoding("UTF-8")

  puts "Supadata response:"
  puts raw_body

  parsed = JSON.parse(raw_body)

  update(
    transcription: parsed["content"],
    language: parsed["lang"]
  )
end


  def enrich
    api_url = "https://api.supadata.ai/v1/youtube/video?id=#{ERB::Util.url_encode(url)}"
    response = HTTParty.get(
      api_url,
      headers: {
        'x-api-key' => ENV['SUPADATA_API_KEY'],
        'Content-Type' => 'application/json'
      }
    )
    response =JSON.parse(response.body)
    update(
      name: response["title"],
      duration: response["duration"],
      thumbnail: response["thumbnail"])
  end

  def generate_summary!
    return nil unless transcription.present?

    summary = SummaryGeneratorService.new(transcription).call
    if summary.present?
      update(summary: summary)
      summary
    else
      nil
    end
  end


  def self.search_by_name_and_tags(query)
    left_joins(:tags)
      .where("contents.name ILIKE :q OR tags.name ILIKE :q", q: "%#{query}%")
      .distinct
  end
end
