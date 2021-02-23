class RemoveIndexIndexShopFoodsOnNameAndShopFromShopFoods < ActiveRecord::Migration[6.0]
  def change
    remove_index :shop_foods, name: "index_shop_foods_on_name_and_shop"
  end
end
