# frozen_string_literal: true

module SeedData
  def self.create_posts(categories, users)
    Rails.logger.debug 'Создание постов...'
    posts = []

    30.times do
      posts << Post.create!(
        title: Faker::Book.unique.title,
        body: Faker::Lorem.paragraph_by_chars(number: rand(1000..3000)),
        category: categories.sample,
        creator: users.sample
      )
    end

    posts
  end
end
