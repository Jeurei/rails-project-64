# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Post.delete_all
Category.delete_all
User.delete_all

users = 5.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

categories = %w[Новости Бизнес Технологии Спорт Культура].map do |name|
  Category.create!(name: name)
end

20.times do
  Post.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: 5).join("\n\n"),
    category: categories.sample,
    creator: users.sample
  )
end
