require 'json'

class QuestionGeneratorService
  def initialize(transcription)
    # Si transcription est un tableau (venant de SupaData), on extrait seulement le texte.
    @transcription = transcription
    @client = OpenAI::Client.new
  end

  def call
    prompt = prompt = <<~PROMPT
  Tu es un assistant pédagogique spécialisé dans la création de quiz pour des étudiants de niveau universitaire.

  À partir du texte ci-dessous, génère **10 questions à choix multiples (QCM)** pertinentes pour tester la compréhension du contenu.
  Les questions doivent être en français.

  ### ❌ Interdictions strictes :
  - Ne pose **aucune question** sur le texte lui-même, son auteur, sa date de publication, ou son contexte.
  - Ne demande pas d'opinion personnelle ou de jugement de valeur.
  - Ne fais **aucune** référence à la source, à une transcription, à la vidéo, au texte, à l'auteur ou à la plateforme dans l'énoncé de la question ou les réponses.
  - Ignore les publicités, partenariats, ou collaborations commerciales.
  - **N’invente aucune information** absente du texte.
  - Ne répète pas les mêmes questions, même reformulées.

  ### 🎯 Objectifs :
  - Chaque question doit aborder **un concept distinct** du texte.
  - Varier les styles de questions : définition, cause/effet, application, déduction, vrai/faux, comparaison, etc.

  ### 🧠 Pour chaque question :
  - Donne une **formulation claire**
  - 4 choix de réponse :
    - A : Bonne réponse
    - B, C, D : Réponses incorrectes mais crédibles
  - Indique **la lettre exacte** de la bonne réponse (A, B, C ou D)
  - Fournis **une explication brève, pédagogique et autonome**

  ### 📦 Format strict :
  Réponds uniquement avec un **array JSON contenant exactement 10 objets**, tous suivant ce format strict :

  [
    {
      "question": "Texte de la question",
      "choices": {
        "A": "Réponse A",
        "B": "Réponse B",
        "C": "Réponse C",
        "D": "Réponse D"
      },
      "correct_answer": "Lettre de la bonne réponse (A, B, C ou D)",
      "explanation": "Brève justification sans mention du texte"
    },
    ...
    (9 autres questions avec le même format)
  ]

  Voici le texte à analyser :

  #{@transcription}
PROMPT


    puts "Prompt to OpenAI:"
    p prompt

    response = @client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.8
      }
    )

    content = response.dig("choices", 0, "message", "content")
    return nil unless content

    begin
      json_text = content.dup
      json_text.gsub!(/\A```json\s*/, '')
      json_text.gsub!(/```+\s*\z/, '')
      json_text.strip!

      raise "Aucun JSON détecté" unless json_text

      JSON.parse(json_text, symbolize_names: true)
    rescue => e
      Rails.logger.error("Erreur dans QuestionGeneratorService : #{e.message}")
      Rails.logger.error("Contenu brut reçu : #{content.inspect}")
      nil
    end
  end
end
