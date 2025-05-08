# frozen_string_literal: true

module SeedData
  def self.create_comments(users, posts)
    Rails.logger.info 'Создание категорий...'
    comments = []

    50.times do
      comments << PostComment.create!(
        content: Faker::Lorem.paragraph(sentence_count: rand(1..5)),
        user: users.sample,
        post: posts.sample
      )
    end

    Rails.logger.info 'Создание вложенных комментариев...'
    30.times do
      parent_comment = comments.sample
      PostComment.create!(
        content: Faker::Lorem.paragraph(sentence_count: rand(1..3)),
        user: users.sample,
        post: parent_comment.post,
        parent: parent_comment
      )
    end

    comments
  end
end
