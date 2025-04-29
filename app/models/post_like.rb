class PostLike < ApplicationRecord
  belongs_to :user, inverse_of: :post_likes
  belongs_to :post, inverse_of: :post_likes
end
