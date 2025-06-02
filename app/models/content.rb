class Content < ApplicationRecord
  belongs_to :user
  has_many :content_tags
  has_many :tags, through: :content_tags
  has_many :questions
  has_many :notes

end
