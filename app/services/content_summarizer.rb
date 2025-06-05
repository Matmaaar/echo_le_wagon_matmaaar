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
  Vous êtes un professeur d’université expert dans le thème abordé dans la transcription ci-dessous. À partir de cette transcription brute, générez un **cours structuré, détaillé et pédagogique** destiné à des étudiants de niveau master.

  ### 🎯 Objectif :
  Produire un support de cours fidèle et complet à partir de la transcription, sans ajout d’informations extérieures.
  Chaque concept doit être expliqué de manière claire, approfondie et pédagogique, comme dans un vrai cours.
  Le contenu doit permettre de réviser en profondeur et de retrouver facilement toutes les explications et informations abordées dans la vidéo. Il ne doit pas être trop court car c'est l'essentiel du contenu.

  ### 🖥️ Format de sortie :
  - Langage : **HTML uniquement** (aucun texte en dehors des balises HTML)
  - ne met pas de balise markdown
  - Structure attendue :
    - <h2>Partie I : Titre</h2>
    - <h3><strong> A. Sous-partie</strong> </h3>
    - <h3>Contenu pédagogique détaillé et fidèle à la transcription, avec exemples si présents dans la transcription</h3>
    - En fin de document : un glossaire des termes techniques
    - <h2>Glossaire</h2>
    - <ul><li><strong>Terme</strong> : Définition courte et claire</li></ul>

  ### 📏 Longueur :
  Le résumé ne doit **pas trop condenser** le contenu. Visez environ **1 ligne de résumé pour 3 à 5 lignes** de transcription.
  Exemple : pour une transcription de 300 lignes, le résumé HTML devrait contenir **60 à 100 lignes** environ.

  ### 🚫 Consignes strictes :
  - Ne mentionnez jamais la vidéo, son auteur, la plateforme, les blagues, la musique ou l’intro/outro.
  - Ne faites pas de résumé global, mais développez chaque point abordé dans la transcription.
  - Ne faites pas de conclusion, le contenu doit être autonome.
  - Développez toutes les idées évoquées, avec des explications claires, précises et pédagogiques.
  - Aucun avis personnel, aucun commentaire, aucun métadiscours.

  Voici la transcription à analyser :
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
