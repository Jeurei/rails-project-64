# frozen_string_literal: true

class ConsolidatedPostLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :post_likes do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false

      t.timestamps null: true
    end

    add_index :post_likes, :user_id
    add_index :post_likes, :post_id
    add_index :post_likes, %i[user_id post_id], unique: true

    add_foreign_key :post_likes, :users, column: :user_id
    add_foreign_key :post_likes, :posts, column: :post_id
  end
end
