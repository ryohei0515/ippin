class RemoveShopFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :shop, :string
  end
end
