# frozen_string_literal: true

class AddNotNullConstraintToCategoryName < ActiveRecord::Migration[7.2]
  def up
    execute("DELETE FROM categories WHERE name IS NULL OR name = ''")

    change_column_null :categories, :name, false
  end

  def down
    change_column_null :categories, :name, true
  end
end
