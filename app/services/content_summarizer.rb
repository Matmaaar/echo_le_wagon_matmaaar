class ContentSummarizer
  def initialize(transcription:)
    # Si transcription est un tableau (comme renvoyé par SupaData), on reconstruit le texte.
    @transcription = if transcription.is_a?(Array)
                       transcription.map { |seg| seg["text"] }.join(" ")
                     else
                       transcription
                     end

    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def call
    prompt = <<~PROMPT
      Résume le texte suivant en un autant de paragraphes qu'il y a de sujets, d'un niveau école supérieure, concis et en français :
      #{@transcription}
    PROMPT

    response = @client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [
          { role: "system", content: "Tu es un assistant qui produit des résumés clairs et fidèles à la transcription." },
          { role: "user", content: prompt }
        ],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")&.strip
  rescue => e
    Rails.logger.error("Erreur dans ContentSummarizer : #{e.message}")
    nil
  end
end
