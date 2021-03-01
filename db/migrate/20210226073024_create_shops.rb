class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops, id: :string do |t|
      t.string :large_area
      t.string :middle_area

      t.timestamps
    end
  end
end
