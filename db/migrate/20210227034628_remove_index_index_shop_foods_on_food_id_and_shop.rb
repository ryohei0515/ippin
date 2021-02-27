class RemoveIndexIndexShopFoodsOnFoodIdAndShop < ActiveRecord::Migration[6.0]
  def change
    remove_index :shop_foods, name: "index_shop_foods_on_food_id_and_shop"
  end
end
