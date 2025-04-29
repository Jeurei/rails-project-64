# frozen_string_literal: true

class AddFieldsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :title, :string
    add_column :posts, :body, :text
    add_reference :posts, :user, null: true, foreign_key: true
    add_reference :posts, :category, null: true, foreign_key: true
  end
end
