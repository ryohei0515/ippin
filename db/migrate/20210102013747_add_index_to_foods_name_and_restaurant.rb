class AddIndexToFoodsNameAndRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_index :foods, [:name, :restaurant], unique: true
  end
end
