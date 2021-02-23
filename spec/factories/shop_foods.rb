# frozen_string_literal: true

FactoryBot.define do
  factory :shop_food, class: ShopFood do
    sequence(:name) { |n| Faker::Food.dish + "_#{n}" }
    sequence(:category) { |n| "Category_#{n}" }
    shop { 'J001170499' }
    rate { Random.rand(8).to_f / 2 + 1 }
    association :food, factory: :food, strategy: :create
  end
end
