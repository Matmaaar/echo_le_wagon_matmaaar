class Question < ApplicationRecord
  belongs_to :content
  has_many :answers, dependent: :destroy

  def validated?
    validated
  end
end
