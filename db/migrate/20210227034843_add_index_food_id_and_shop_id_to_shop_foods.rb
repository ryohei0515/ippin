class AddIndexFoodIdAndShopIdToShopFoods < ActiveRecord::Migration[6.0]
  def change
    add_index :shop_foods, [:food_id, :shop_id], unique: true
  end
end
