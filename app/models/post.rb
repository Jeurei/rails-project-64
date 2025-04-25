class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"
  has_many :post_likes, dependent: :destroy
  has_many :liked_posts, through: :post_likes, source: :post
  has_many :comments, class_name: "PostComment", dependent: :destroy
end
