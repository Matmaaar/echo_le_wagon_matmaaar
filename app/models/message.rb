class Message < ApplicationRecord
  belongs_to :content
  validates :user_question, presence: true
  after_create :fetch_ai_answer

  after_create_commit -> {
    broadcast_append_to "messages_for_content_#{content.id}",
                       target: "message",
                       partial: "messages/message",
                       locals: { message: self }
  }

   after_update_commit -> {
    broadcast_replace_to "messages_for_content_#{content.id}",
                        target: "message_#{id}",
                        partial: "messages/message",
                        locals: { message: self }
  }

  private

  def fetch_ai_answer
    ChatbotJob.perform_later(self)
  end
end
