require 'json'

class TagContentFromAi
  def initialize(content)
    @content = content
  end

  def call
    tags = generate_tags(@content.transcription.map { |chunk| chunk["text"] }.join(" "))

    tags.each do |tag_name|
      tag = Tag.find_or_create_by!(name: tag_name.downcase)
      @content.tags << tag unless @content.tags.include?(tag)
    end

    tags
  end

  private

  def generate_tags(text)
    client = OpenAI::Client.new
    prompt = <<~PROMPT
      Analyze this text and identify three key concepts, each expressed in a single word, that reflect the general themes discussed. List them separated by commas, without adding any explanatory phrases.

      Texte :
      #{text}
    PROMPT

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini", # ou "gpt-3.5-turbo"
        messages: [{ role: "user", content: prompt }],
        temperature: 0.5
      }
    )

    raw = response.dig("choices", 0, "message", "content")
    raw.split(',').map(&:strip).first(3)
  end
end
