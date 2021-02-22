class AddFoodIdToShopFoods < ActiveRecord::Migration[6.0]
  def change
    add_reference :shop_foods, :food, null: false, foreign_key: true
  end
end
