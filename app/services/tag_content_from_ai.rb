require 'json'

class TagContentFromAi
  def initialize(content)
    @content = content
  end

  def call
    tags = generate_tags(
      @content.transcription
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
      Analyze the following text and identify its main themes.
      From the list below, select exactly three keywords that best match the content.
      You must strictly choose from this list: [Nature, Science, Travel, Art, Society, Culture, History, Sport, Cooking, Politics, Education, Philosophy, Psychology, Technology, Health, Environment, Economy, Media, Entertainment, Other]
      Rules:
      - Use only words from the list, no exceptions.
      - Return exactly three words, separated only by commas.
      - No explanations, no punctuation, no quotation marks, no extra words.
      - If none of the listed categories fit, use "Other" — but only if truly necessary.
      Example output (correct): Nature, Science, History
      Example output (incorrect): The main themes are Nature, Science and History.

      Text:


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
