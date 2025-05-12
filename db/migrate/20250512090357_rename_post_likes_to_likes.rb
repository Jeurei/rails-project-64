# frozen_string_literal: true

class RenamePostLikesToLikes < ActiveRecord::Migration[7.2]
  def change
    rename_table :post_likes, :likes
  end
end
