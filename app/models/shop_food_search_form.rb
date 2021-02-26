# frozen_string_literal: true

class ShopFoodSearchForm
  include ActiveModel::Model

  attr_accessor :food_id

  validates :food_id, presence: true

  def search
    ShopFood.where(food_id: food_id)
  end
end
