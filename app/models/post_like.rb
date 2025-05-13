# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user, inverse_of: :likes, primary_key: 'id'
  belongs_to :post, inverse_of: :likes, counter_cache: :likes_count, primary_key: 'id'
end
