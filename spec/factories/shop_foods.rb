# frozen_string_literal: true

FactoryBot.define do
  factory :shop_food, class: ShopFood do
    shop { 'J001170499' }
    rate { Random.rand(8).to_f / 2 + 1 }
    association :food, factory: :food, strategy: :create
  end
end
