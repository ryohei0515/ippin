class CreateShopFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :shop_foods do |t|
      t.string :name
      t.string :category
      t.string :shop

      t.timestamps
    end
  end
end
