class Content < ApplicationRecord
  belongs_to :user
  has_many :content_tags
  has_many :tags, through: :content_tags
  has_many :questions
  has_many :notes

  def generate_question
    QuestionGeneratorService.new(self).call
  end

end
