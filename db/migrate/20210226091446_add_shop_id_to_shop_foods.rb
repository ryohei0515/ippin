class AddShopIdToShopFoods < ActiveRecord::Migration[6.0]
  def change
    add_reference :shop_foods, :shop, type: :string, null: false, foreign_key: true
  end
end
