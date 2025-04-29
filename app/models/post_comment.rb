# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: { maximum: 1000 }
end
