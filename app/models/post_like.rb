# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user, inverse_of: :post_likes
  belongs_to :post, inverse_of: :post_likes, counter_cache: :likes_count
end
