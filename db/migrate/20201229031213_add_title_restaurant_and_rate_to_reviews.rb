class AddTitleRestaurantAndRateToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :title, :string
    add_column :reviews, :restaurant, :string
    add_column :reviews, :rate, :float
  end
end
