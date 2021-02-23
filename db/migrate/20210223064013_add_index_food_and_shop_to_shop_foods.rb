class AddIndexFoodAndShopToShopFoods < ActiveRecord::Migration[6.0]
  def change
    add_index :shop_foods, [:food_id, :shop], unique: true
  end
end
