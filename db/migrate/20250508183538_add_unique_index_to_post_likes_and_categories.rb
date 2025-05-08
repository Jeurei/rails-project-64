# frozen_string_literal: true

class AddUniqueIndexToPostLikesAndCategories < ActiveRecord::Migration[7.2]
  def change
    add_index :post_likes, %i[user_id post_id], unique: true
    add_index :categories, :name, unique: true
  end
end
