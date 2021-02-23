class AddIndexToShopFoodsRate < ActiveRecord::Migration[6.0]
  def change
    add_index :shop_foods, :rate
  end
end
