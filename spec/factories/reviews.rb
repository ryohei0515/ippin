FactoryBot.define do
  factory :review, class: Review do
    content { "おいしい" }
    food { "カレー" }
    association :user, factory: :review_user, strategy: :create

    trait :created_30_minutes_ago do
      created_at { 30.minutes.ago }
    end
    trait :created_20_minutes_ago do
      created_at { 20.minutes.ago }
    end
    trait :created_most_recent do
      created_at { 10.minutes.ago }
    end
  end

  factory :review_user, class: User do
    name { "Review User" }
    sequence(:email) { |n| "review_#{n}@example.com"}
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
