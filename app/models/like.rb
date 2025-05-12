# frozen_string_literal: true

class Like < ApplicationRecord
  self.table_name = 'post_likes'
  belongs_to :user, inverse_of: :likes
  belongs_to :post, inverse_of: :likes, counter_cache: :likes_count
end
