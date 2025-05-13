# frozen_string_literal: true

class Like < ApplicationRecord
  self.table_name = 'post_likes'

  belongs_to :user, inverse_of: :likes, foreign_key: 'user', primary_key: 'id'
  belongs_to :post, inverse_of: :likes, counter_cache: :likes_count, foreign_key: 'post', primary_key: 'id'

  def user_id
    self[:user]
  end

  def post_id
    self[:post]
  end

  def user=(value)
    self[:user] = value.is_a?(User) ? value.id : value
  end

  def post=(value)
    self[:post] = value.is_a?(Post) ? value.id : value
  end
end
