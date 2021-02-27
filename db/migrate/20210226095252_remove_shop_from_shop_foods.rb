class RemoveShopFromShopFoods < ActiveRecord::Migration[6.0]
  def change
    remove_column :shop_foods, :shop, :string
  end
end
