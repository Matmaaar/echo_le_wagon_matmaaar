class ContentTag < ApplicationRecord
  belongs_to :tag
  belongs_to :content

  def favorite?
    favorite
  end
end
