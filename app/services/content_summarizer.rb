class ContentSummarizer
  # transcription: texte intégral de la vidéo
  def initialize(transcription:)
    @transcription = transcription
    @client     = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def call
    # si votre transcription est trop long, il faudra le chunker en plusieurs morceaux
    prompt = <<~PROMPT
      Résume le texte suivant en un autant de paragraphe qu'il y a de sujet, d'un niveau école superieur, concis et en français :
      #{@transcription}
    PROMPT

    response = @client.chat(
      parameters: {
        model:   "gpt-4o",
        messages: [
          { role: "system", content: "Tu es un assistant qui produit des résumés clairs et fidel a la transcription." },
          { role: "user",   content: prompt }
        ],
        temperature: 0.7
      }
    )

    # On récupère juste le texte généré
    response.dig("choices", 0, "message", "content")&.strip
  end
end
