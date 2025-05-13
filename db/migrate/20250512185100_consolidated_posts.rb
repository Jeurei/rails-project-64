# frozen_string_literal: true

class ConsolidatedPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :category, null: true, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end
  end
end
