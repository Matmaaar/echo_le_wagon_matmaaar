class QuestionGeneratorService
  def initialize(transcription)
    @transcription = transcription
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def call
    prompt = <<~PROMPT
      Tu es un assistant pédagogique. Lis cette transcription de vidéo, et génère 5 questions de compréhension pertinentes :

      #{@transcription}

      Merci de formuler les questions clairement.
    PROMPT

    response = @client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [
          { role: "user", content: prompt }
        ],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end
