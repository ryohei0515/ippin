# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Example User' }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end

  factory :other_user, class: User do
    name { 'Other User' }
    email { 'other_user@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end

  factory :sample_user, class: User do
    id { Settings.sample_user.id }
    name { 'Sample User' }
    email { Settings.sample_user.email }
    password { Settings.sample_user.password }
    password_confirmation { Settings.sample_user.password }
  end
end
