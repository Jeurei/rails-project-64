# frozen_string_literal: true

class AddPostCommentReferences < ActiveRecord::Migration[7.2]
  def change
    add_reference :post_comments, :post, null: true, foreign_key: true
    add_reference :post_comments, :user, null: true, foreign_key: true
  end
end
