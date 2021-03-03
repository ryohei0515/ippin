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
end
