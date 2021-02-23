# frozen_string_literal: true

FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "food_#{n}" }
    sequence(:name_kana) { |n| "food_kana_#{n}" }
    sequence(:category) { |n| "category_#{n}" }
    sequence(:description) { |n| "description_#{n}" }
  end
end
