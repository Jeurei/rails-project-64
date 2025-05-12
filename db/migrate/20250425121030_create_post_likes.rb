# frozen_string_literal: true

class CreatePostLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :post_likes do |t|
      t.references :user, null: true, foreign_key: true
      t.references :post, null: true, foreign_key: true

      t.timestamps null: true
    end
  end
end
