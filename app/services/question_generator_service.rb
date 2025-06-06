require 'json'

class QuestionGeneratorService
  def initialize(transcription)
    # Si transcription est un tableau (venant de SupaData), on extrait seulement le texte.
    @transcription = if transcription.is_a?(Array)
                       transcription.map { |seg| seg["text"] }.join(" ")
                     else
                       transcription
                     end
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def call
    prompt = <<~PROMPT
      Tu es un assistant pédagogique spécialisé dans la création de quiz pour des étudiants de niveau universitaire.

      À partir du texte ci-dessous, génère **une seule** question à choix multiples (QCM) pertinente pour tester la compréhension du contenu.

      ### ❌ Interdictions :
      - Ne fais aucune référence à la transcription, à une vidéo, à un auteur ou à une plateforme.
      - La question et ses réponses doivent être **autonomes et compréhensibles seules**.
      - N’invente aucune information absente du texte.
      - Ne répète pas des questions précédentes si appelées plusieurs fois.

      ### 🎯 Objectif :
      - Couvrir **un concept distinct** abordé dans le texte.
      - La question doit être claire, précise et pertinente.
      - Varie le style : définition, cause/effet, application, déduction, vrai/faux, comparaison, etc.

      ### 🧠 Pour la question :
      - Propose une question claire.
      - Donne 4 choix de réponse :
        - A : Bonne réponse
        - B, C, D : Réponses incorrectes mais crédibles
      - Indique la lettre de la bonne réponse.
      - Donne une explication brève et pédagogique, **sans jamais mentionner le texte d’origine**.

      ### 📦 Format strict :
      Retourne un **objet JSON** au format suivant :
      {
        "question": "Texte de la question",
        "choices": {
          "A": "Réponse A",
          "B": "Réponse B",
          "C": "Réponse C",
          "D": "Réponse D"
        },
        "correct_answer": "Lettre de la bonne réponse",
        "explanation": "Brève justification sans mention du texte ou de la vidéo"
      }

      Voici le texte à analyser :

      #{@transcription}
    PROMPT

    puts "Prompt to OpenAI:"
    p prompt

    response = @client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.7
      }
    )

    content = response.dig("choices", 0, "message", "content")
    return nil unless content

    begin
      json_text = content.dup
      json_text.gsub!(/\A```json\s*/, '')
      json_text.gsub!(/```+\s*\z/, '')
      json_text = json_text[/\{.*\}/m]

      raise "Aucun JSON détecté" unless json_text

      JSON.parse(json_text, symbolize_names: true)
    rescue => e
      Rails.logger.error("Erreur dans QuestionGeneratorService : #{e.message}")
      Rails.logger.error("Contenu brut reçu : #{content.inspect}")
      nil
    end
  end
end
