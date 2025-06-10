class Message < ApplicationRecord
  belongs_to :content
  validates :user_question, presence: true
  after_create :fetch_ai_answer

  after_update_commit :broadcast_full_message

  private

  def fetch_ai_answer
    broadcast_append_to "messages_for_content_#{content.id}",
                       target: "messages",
                       partial: "messages/message",
                       locals: { message: self }
    ChatbotJob.perform_later(self)
  end

  def broadcast_full_message
    Rails.logger.info "Broadcasting full message for content #{content.id} and message #{id}"
    broadcast_replace_to "messages_for_content_#{content.id}",
                         target: "message_#{id}",
                         partial: "messages/message",
                          locals: { message: self }
  end
end
