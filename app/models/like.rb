# frozen_string_literal: true

class Like < ApplicationRecord
  self.table_name = 'post_likes'
  belongs_to :user, inverse_of: :likes, foreign_key: 'user'
  belongs_to :post, inverse_of: :likes, counter_cache: :likes_count, foreign_key: 'post'

  def post_id
    self[:post]
  end

  def post_id=(value)
    self[:post] = value
  end

  def user_id
    self[:user]
  end

  def user_id=(value)
    self[:user] = value
  end

  def post=(value)
    self[:post] = if value.is_a?(Post)
                    value.id
                  else
                    value
                  end
  end

  def user=(value)
    self[:user] = if value.is_a?(User)
                    value.id
                  else
                    value
                  end
  end
end
