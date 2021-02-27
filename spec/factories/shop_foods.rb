# frozen_string_literal: true

FactoryBot.define do
  factory :shop_food, class: ShopFood do
    # shop_list = %w[J001259384 J001233764 J001249396 J000133890 J001145797 J001261533 J001192710 J001262652 J001232591 J001098481]
    # sequence(:shop) { |n| shop_list[n % 10] }
    rate { Random.rand(8).to_f / 2 + 1 }
    association :food, factory: :food, strategy: :create
    association :shop, factory: :shop, strategy: :create
  end
end
