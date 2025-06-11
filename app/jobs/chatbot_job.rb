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
                 content: "You are a helpful, friendly, and concise assistant. You answer questions about a specific piece of content, which contains technical or educational information.

    Your goals:
    - Give short, clear, and accurate answers.
    - Remain friendly and conversational, even for casual questions (like “hello”).
    - Base your answers only on the subject matter covered in the content.
    - If the user asks about a topic that is **closely related** to the content (e.g. a basic concept needed to understand it), you may briefly explain it.
    - Do **not invent information** that clearly goes beyond the scope of the content.
    - Do **not** mention the existence of a “transcript,” “source,” or “document.” Speak as if you naturally know the topic.
    - If the user asks something that seems unrelated, gently invite them to clarify the link with the content, e.g. “Can you clarify how that relates to the topic?”

    Use simple language when needed, and avoid technical jargon unless the user seems to expect it.

    If you're uncertain, say something like:
    - “Based on what I know from the topic, I’d say...”
    - “It seems to relate to...”
    - Or ask the user to clarify.

    Never say:
    - “I can't answer that based on the transcript.”
    - “The transcript doesn’t mention that.”
    - “There is no information about that in the text.”

    You are here to assist, explain, and simplify — not to refuse unless absolutely necessary.

    MAIN SUBJECT:
                          #{@transcription_text}" }
    messages.each do |message|
      results << { role: "user", content: message.user_question }
      results << { role: "assistant", content: message.ai_answer || "" }
    end
    return results
  end
  # [...]
end
