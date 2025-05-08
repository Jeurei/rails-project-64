# frozen_string_literal: true

require 'faker'

Faker::Config.locale = 'ru'

Rails.logger.debug 'Очистка базы данных...'
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
SeedData.create_comments(users, posts)
SeedData.create_likes(users, posts)

Rails.logger.debug 'Создание данных завершено!'
Rails.logger.debug { "Создано #{User.count} пользователей" }
Rails.logger.debug { "Создано #{Category.count} категорий" }
Rails.logger.debug { "Создано #{Post.count} постов" }
Rails.logger.debug { "Создано #{PostComment.count} комментариев" }
Rails.logger.debug { "Создано #{PostLike.count} лайков" }
