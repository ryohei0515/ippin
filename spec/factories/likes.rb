# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :user, factory: :user, strategy: :create
    association :review, factory: :review, strategy: :create
  end
end
