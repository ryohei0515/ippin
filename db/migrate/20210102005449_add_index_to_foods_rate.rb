class AddIndexToFoodsRate < ActiveRecord::Migration[6.0]
  def change
    add_index :foods, :rate
  end
end
