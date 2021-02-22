class AddShopFoodIdToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :shop_food, null: false, foreign_key: true
  end
end
