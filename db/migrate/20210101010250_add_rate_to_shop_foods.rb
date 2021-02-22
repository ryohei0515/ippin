class AddRateToShopFoods < ActiveRecord::Migration[6.0]
  def change
    add_column :shop_foods, :rate, :float
  end
end
