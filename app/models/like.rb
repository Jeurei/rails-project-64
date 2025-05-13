# frozen_string_literal: true

class Like < ApplicationRecord
  self.table_name = 'post_likes'

  belongs_to :user, inverse_of: :likes, foreign_key: 'user', primary_key: 'id'
  belongs_to :post, inverse_of: :likes, counter_cache: :likes_count, foreign_key: 'post', primary_key: 'id'

  # Define methods for standard Rails conventions
  def user_id
    self[:user]
  end

  def post_id
    self[:post]
  end

  # Handle assignment for user attribute
  # This supports both fixtures and regular usage
  def user=(value)
    self[:user] = if value.is_a?(User)
                    value.id
                  elsif value.respond_to?(:to_i)
                    value.to_i
                  else
                    value
                  end
  end

  # Handle assignment for post attribute
  # This supports both fixtures and regular usage
  def post=(value)
    self[:post] = if value.is_a?(Post)
                    value.id
                  elsif value.respond_to?(:to_i)
                    value.to_i
                  else
                    value
                  end
  end
end
