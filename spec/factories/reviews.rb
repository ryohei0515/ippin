FactoryBot.define do
  factory :review, class: Review do
    content { "おいしい" }
    food { "カレー" }
    association :user, factory: :review_user, strategy: :create
  end

  factory :review_30_minutes_ago, class: Review do
    content { "まあまあ" }
    food { "シチュー" }
    created_at { 30.minutes.ago }
    association :user, factory: :review_user, strategy: :create
  end

  factory :review_20_minutes_ago, class: Review do
    content { "普通" }
    food { "ハンバーグ" }
    created_at { 20.minutes.ago }
    association :user, factory: :review_user, strategy: :create
  end

  factory :review_most_recent, class: Review do
    content { "おいしかった" }
    food { "カツ丼" }
    created_at { 10.minutes.ago }
    association :user, factory: :review_user, strategy: :create
  end

  factory :review_user, class: User do
    name { "Review User" }
    sequence(:email) { |n| "review_#{n}@example.com"}
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
