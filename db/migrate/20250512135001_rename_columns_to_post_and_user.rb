# frozen_string_literal: true

class RenameColumnsToPostAndUser < ActiveRecord::Migration[7.2]
  def change
    rename_column :post_likes, :post_id, :post
    rename_column :post_likes, :user_id, :user
  end
end
