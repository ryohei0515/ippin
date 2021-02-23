class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :name_kana
      t.string :category
      t.string :description

      t.timestamps
    end
  end
end
