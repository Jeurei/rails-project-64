# frozen_string_literal: true

module SeedData
  def self.create_users
    Rails.logger.info 'Создание пользователей...'
    admin = User.create!(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    users = [admin]

    10.times do
      users << User.create!(
        email: Faker::Internet.unique.email,
        password: 'password',
        password_confirmation: 'password'
      )
    end

    users
  end
end
