class ContentTag < ApplicationRecord
  belongs_to :tag
  belongs_to :content

  after_commit :broadcast_tag_update

  def favorite?
    favorite
  end

  private

  def broadcast_tag_update
    broadcast_replace_to(
      "content_#{content.id}_tags",
      target: "tags",
      partial: "tags/button_tags",
      locals: { content: content }
    )
  end
end
