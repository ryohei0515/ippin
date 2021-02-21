# frozen_string_literal: true

FactoryBot.define do
  factory :food, class: Food do
    sequence(:name) { |n| Faker::Food.dish + "_#{n}" }
    sequence(:category) { |n| "Category_#{n}" }
    shop { 'J001170499' }
    rate { Random.rand(8).to_f / 2 + 1 }
  end
end
