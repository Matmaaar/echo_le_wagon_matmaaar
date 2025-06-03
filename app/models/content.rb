   require "erb"
class Content < ApplicationRecord
  belongs_to :user
  has_many :content_tags
  has_many :tags, through: :content_tags
  has_many :questions
  has_many :notes


  def get_transcript
    api_url = "https://api.supadata.ai/v1/youtube/transcript?url=#{ERB::Util.url_encode(url)}&lang=fr"
    response = HTTParty.get(
      api_url,
      headers: {
        'x-api-key' => ENV['SUPADATA_API_KEY'],
        'Content-Type' => 'application/json'
      }
    )
    JSON.parse(response.body)
  end
end
