# frozen_string_literal: true

module SeedData
  def self.create_categories
    Rails.logger.debug 'Создание категорий...'

    %w[
      Технологии
      Спорт
      Наука
      Искусство
      Путешествия
      Здоровье
      Образование
      Кулинария
      Бизнес
      Мода
    ].map do |name|
      Category.create!(name: name)
    end
  end
end
