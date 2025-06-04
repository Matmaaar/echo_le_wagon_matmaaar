require 'json'

class SummaryGeneratorService
  def initialize(transcription)
    @transcription = transcription
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def call
    prompt = <<~PROMPT
      Tu es un assistant pédagogique. Lis cette transcription de vidéo, puis génère un résumé clair et concis de son contenu, en quelques phrases.

      Transcription :
      #{@transcription}
    PROMPT

    puts "Prompt to OpenAI for summary:"
    p prompt

    response = @client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.5
      }
    )

    content = response.dig("choices", 0, "message", "content")
    return nil unless content

    # Nettoyer le contenu, si nécessaire (ex: enlever ```)
    summary = content.dup
    summary.gsub!(/\A```+\s*/, '')
    summary.gsub!(/```+\s*\z/, '')

    summary.strip
  rescue => e
    Rails.logger.error("Erreur dans SummaryGeneratorService: #{e.message}")
    nil
  end
end
