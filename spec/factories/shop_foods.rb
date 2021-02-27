# frozen_string_literal: true

FactoryBot.define do
  factory :shop_food, class: ShopFood do
    rate { Random.rand(8).to_f / 2 + 1 }
    association :food, factory: :food, strategy: :create
    association :shop, factory: :shop, strategy: :create

    factory :shop_food_specific_large_area do
      shop { create(:shop, :specific_large_area) }
    end

    factory :shop_food_specific_middle_area do
      shop { create(:shop, :specific_middle_area) }
    end
  end
end
