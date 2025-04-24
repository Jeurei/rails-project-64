class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"
  has_many :comments, class_name: "PostComment", dependent: :destroy
end
