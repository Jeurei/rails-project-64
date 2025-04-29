# frozen_string_literal: true

class RemoveUserIdFromPosts < ActiveRecord::Migration[7.2]
  def change
    remove_reference :posts, :user, null: false, foreign_key: true
  end
end
