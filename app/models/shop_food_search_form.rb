# frozen_string_literal: true

class ShopFoodSearchForm
  include ActiveModel::Model

  attr_accessor :food_id, :large_area, :middle_area

  validates :food_id, presence: true

  def search
    return ShopFood.where('1=0') if invalid? # バリデーションエラー時、空で返却

    query = "food_id = #{food_id}"
    query += " AND shops.large_area = '#{large_area}'" if large_area.present?
    query += " AND shops.middle_area = '#{middle_area}'" if middle_area.present?
    ShopFood.joins(:shop).where(query)
  end
end
