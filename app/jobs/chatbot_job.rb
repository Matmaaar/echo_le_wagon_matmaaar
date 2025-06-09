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
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@message.id}",
      target: "question_#{@message.id}",
      partial: "messages/message", locals: { message: message })
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

   def questions_formatted_for_openai
    messages = @message.content.messages
    results = []
    results << { role: "system", content: "You are an assistant that helps me answer questions on some content." }
    messages.each do |message|
      results << { role: "user", content: message.user_question }
      results << { role: "assistant", content: message.ai_answer || "" }
    end
    return results
  end
  # [...]
end
