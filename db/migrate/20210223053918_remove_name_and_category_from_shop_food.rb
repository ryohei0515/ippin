class RemoveNameAndCategoryFromShopFood < ActiveRecord::Migration[6.0]
  def change
    remove_column :shop_foods, :name, :string
    remove_column :shop_foods, :category, :string
  end
end
