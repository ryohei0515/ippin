class AddRateToFoods < ActiveRecord::Migration[6.0]
  def change
    add_column :foods, :rate, :float
  end
end
