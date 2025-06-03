require 'json'

class QuestionGeneratorService
  def initialize(transcription)
    @transcription = transcription
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def call
    prompt = <<~PROMPT
      Tu es un assistant pédagogique. Lis cette transcription de vidéo, et génère une question pertinente à partir de ce contenu. Propose 4 réponses :
      La première est la bonne réponse.
      Les trois autres sont fausses mais doivent paraître plausibles.
      Identifie et affiche la lettre correspondant à la bonne réponse (ex. A, B, C, D).
      Donne une brève explication qui justifie pourquoi cette réponse est correcte.
      Renvoie l’ensemble au format JSON, selon cette structure :
        {
        "question": "Texte de la question",
        "choices": {
            "A": "Réponse A",
            "B": "Réponse B",
            "C": "Réponse C",
            "D": "Réponse D"
        },
        "correct_answer": "Lettre de la bonne réponse",
        "explanation": "Explication de la bonne réponse",
        }

      Voici la transcription :

      #{@transcription}
    PROMPT
    
    puts "Prompt to OpenAI:"
    p prompt
    response = @client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [
          { role: "user", content: prompt }
        ],
        temperature: 0.7
      }
    )

    content = response.dig("choices", 0, "message", "content")
    content.gsub!(/\A```json\s*/, '') 
    content.gsub!(/```+\s*\z/, '')
    JSON.parse(content, symbolize_names: true)
    end
end
