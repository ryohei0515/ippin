FactoryBot.define do
  factory :food, class: Food do
    name { Faker::Food.dish }
    sequence(:category) { |n| "Category_#{n}" }
    sequence(:restaurant) { |n| "Restaurant_#{n}" }
  end
end
