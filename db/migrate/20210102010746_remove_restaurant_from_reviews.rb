class RemoveRestaurantFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :restaurant, :string
  end
end
