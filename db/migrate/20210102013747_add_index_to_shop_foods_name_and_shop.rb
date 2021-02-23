class AddIndexToShopFoodsNameAndShop < ActiveRecord::Migration[6.0]
  def change
    add_index :shop_foods, [:name, :shop], unique: true
  end
end
