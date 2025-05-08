# frozen_string_literal: true

require 'faker'

Faker::Config.locale = 'ru'

puts 'Очистка базы данных...'
PostLike.destroy_all
PostComment.destroy_all
Post.destroy_all
Category.destroy_all
User.destroy_all

require_relative 'seeds/categories'
require_relative 'seeds/users'
require_relative 'seeds/posts'
require_relative 'seeds/post_comments'
require_relative 'seeds/post_likes'

categories = SeedData.create_categories
users = SeedData.create_users
posts = SeedData.create_posts(categories, users)
comments = SeedData.create_comments(users, posts)
SeedData.create_likes(users, posts)

puts 'Создание данных завершено!'
puts "Создано #{User.count} пользователей"
puts "Создано #{Category.count} категорий"
puts "Создано #{Post.count} постов"
puts "Создано #{PostComment.count} комментариев"
puts "Создано #{PostLike.count} лайков"
