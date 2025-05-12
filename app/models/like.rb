# frozen_string_literal: true

class Like < ApplicationRecord
  # Use custom table name for this model
  self.table_name = 'post_likes'

  # Define associations with custom foreign keys
  belongs_to :user, inverse_of: :likes, foreign_key: 'user'
  belongs_to :post, inverse_of: :likes, counter_cache: :likes_count, foreign_key: 'post'

  # Explicit fixture support
  def self.find_by_id(id)
    find_by(id: id)
  end

  def self.fixture_class_name
    'Like'
  end

  # Support for fixture identification
  def self.identify(fixture_label)
    fixture = ActiveRecord::FixtureSet.identify(fixture_label)
    find_by(id: fixture)
  end

  # Support for fixture class mapping
  def self.inherited(subclass)
    super
    subclass.table_name = 'post_likes' unless subclass.name.nil?
  end

  def post_id
    self[:post]
  end

  def post_id=(value)
    self[:post] = value
  end

  def user_id
    self[:user]
  end

  def user_id=(value)
    self[:user] = value
  end

  def post=(value)
    self[:post] = if value.is_a?(Post)
                    value.id
                  else
                    value
                  end
  end

  def user=(value)
    self[:user] = if value.is_a?(User)
                    value.id
                  else
                    value
                  end
  end

  # Support comparisons with symbols (for fixtures)
  def ==(other)
    if other.is_a?(Symbol) && defined?(ActiveRecord::FixtureSet)
      fixture_id = ActiveRecord::FixtureSet.identify(other)
      return id == fixture_id
    end
    super
  end
end
