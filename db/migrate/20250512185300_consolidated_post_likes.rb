# frozen_string_literal: true

class ConsolidatedPostLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :post_likes do |t|
      t.integer :user, null: false
      t.integer :post, null: false

      t.timestamps null: true
    end

    add_index :post_likes, :user
    add_index :post_likes, :post
    add_index :post_likes, %i[user post], unique: true

    add_foreign_key :post_likes, :users, column: :user
    add_foreign_key :post_likes, :posts, column: :post
  end
end
