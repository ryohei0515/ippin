# frozen_string_literal: true

class ShopFoodSearchForm
  include ActiveModel::Model

  attr_accessor :food_id

  validates :food_id, presence: true
end
