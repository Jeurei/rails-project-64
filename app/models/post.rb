# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :creator, class_name: 'User'
  has_many :likes, class_name: 'Like', dependent: :destroy, inverse_of: :post, foreign_key: 'post'
  has_many :comments, class_name: 'PostComment', dependent: :destroy

  validates :title, presence: true, length: { minimum: 5, maximum: 255 }
  validates :body, presence: true, length: { minimum: 200, maximum: 4000 }
end
