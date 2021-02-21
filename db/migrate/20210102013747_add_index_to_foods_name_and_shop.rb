class AddIndexToFoodsNameAndShop < ActiveRecord::Migration[6.0]
  def change
    add_index :foods, [:name, :shop], unique: true
  end
end
