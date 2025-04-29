# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts, &:timestamps
  end
end
