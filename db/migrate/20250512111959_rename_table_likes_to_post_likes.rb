class RenameTableLikesToPostLikes < ActiveRecord::Migration[7.2]
  def change
    rename_table :likes, :post_likes
  end
end
