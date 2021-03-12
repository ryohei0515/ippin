# frozen_string_literal: true

FactoryBot.define do
  factory :review, class: Review do
    content { Faker::Lorem.sentence(word_count: 5) }
    rate { Random.rand(4).to_f + 1 }
    title { Faker::Lorem.sentence(word_count: 2) }
    association :user, factory: :review_user, strategy: :create
    association :shop_food, factory: :shop_food, strategy: :create

    sequence(:created_at) { |n| (n + 1).days.ago }
    sequence(:updated_at) { |n| n.hours.ago }

    trait :created_30_minutes_ago do
      created_at { 30.minutes.ago }
      updated_at { 30.minutes.ago }
    end
    trait :created_20_minutes_ago do
      created_at { 20.minutes.ago }
      updated_at { 20.minutes.ago }
    end
    trait :created_10_minutes_ago do
      created_at { 10.minutes.ago }
      updated_at { 10.minutes.ago }
    end

    trait :picture do
      picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/test_pic_01.jpg'), 'image/jpeg') }
    end
  end

  factory :review_user, class: User do
    name { 'Review User' }
    sequence(:email) { |n| "review_#{n}@example.com" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
