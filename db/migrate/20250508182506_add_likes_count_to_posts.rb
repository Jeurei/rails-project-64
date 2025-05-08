# frozen_string_literal: true

class AddLikesCountToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :likes_count, :integer, default: 0, null: false
    
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE posts
          SET likes_count = (
            SELECT COUNT(*)
            FROM post_likes
            WHERE post_likes.post_id = posts.id
          )
        SQL
      end
    end
  end
end
