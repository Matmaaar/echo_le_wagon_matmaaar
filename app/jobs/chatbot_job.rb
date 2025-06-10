class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(message)
    Rails.logger.info "ChatbotJob started for message ID: #{message.id}"
    @message = message
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: questions_formatted_for_openai # to code as private method
      }
    )
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    message.update(ai_answer: new_content)

  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

   def questions_formatted_for_openai
    @transcription = @message.content.transcription
    @transcription_text = @transcription.map { |seg| seg["text"] }.join(" ")
    messages = @message.content.messages
    results = []
    results << { role: "system",
                 content: "You are a helpful, friendly assistant designed to answer user questions based only on a specific content.

    You are allowed to:
    - Greet the user warmly.
    - Explain general concepts briefly if — and only if — they are clearly related to the main topic of the content.
    - Provide short and clear answers. If the user requests more detail, you can expand your answers.

    You must not:
    - Invent facts, dates, or names that are not explicitly present in the content.
    - Answer questions on topics that are not clearly related to the content.
    - Mention that you are basing your answers on a transcript or written text.

    If the user asks about something unrelated or too far from the content, respond kindly with:
    *“I’m here to help with questions related to the main topic. Could you clarify or ask something more specific to the content?”*

    MAIN TOPIC:
                          #{@transcription_text}" }
    messages.each do |message|
      results << { role: "user", content: message.user_question }
      results << { role: "assistant", content: message.ai_answer || "" }
    end
    return results
  end
  # [...]
end
