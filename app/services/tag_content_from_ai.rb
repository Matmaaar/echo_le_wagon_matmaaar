require 'json'

class TagContentFromAi
  def initialize(content)
    @content = content
  end

  def call
    tags = generate_tags(
      @content.transcription.map { |chunk| chunk["text"] }.join(" ")
    )

    tags.each do |tag_name|
      tag = Tag.find_or_create_by!(name: tag_name.downcase.capitalize)
      @content.tags << tag unless @content.tags.include?(tag)
    end

    tags
  end

  private

  def generate_tags(text)
    client = OpenAI::Client.new
    prompt = <<~PROMPT
      Analyze this text and identify key concepts, that reflect the general themes discussed.
      Pick from the following list [Nature, Science, Travel, Art, Society, Culture, History, Sport, Cooking, Politics, Other],
      two to three words that best represent the text. Pick only Other if no other words fit.
      List them separated by commas, without adding any explanatory phrases.
      Example:
      Text: “Tropical rainforests are home to thousands of species…”
      Response: Nature, Science

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
