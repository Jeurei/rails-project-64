# frozen_string_literal: true

class ConsolidatedCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :categories, :name, unique: true
  end
end
