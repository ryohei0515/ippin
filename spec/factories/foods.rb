# frozen_string_literal: true

FactoryBot.define do
  factory :food do
    name { 'MyString' }
    name_kana { 'MyString' }
    category { 'MyString' }
    description { 'MyString' }
  end
end
