# frozen_string_literal: true

module SeedData
  def self.create_likes(users, posts)
    Rails.logger.debug 'Создание лайков...'
    likes_combinations = []

    users.each do |user|
      liked_posts = posts.sample(rand(5..15))

      liked_posts.each do |post|
        combo = [user.id, post.id]
        next if likes_combinations.include?(combo)

        Like.create!(user: user, post: post)
        likes_combinations << combo
      end
    end
  end
end
