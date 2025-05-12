# frozen_string_literal: true

class RevertColumnsInPostLikes < ActiveRecord::Migration[7.2]
  def change
    rename_column :post_likes, :post, :post_id
    rename_column :post_likes, :user, :user_id
  end
end
