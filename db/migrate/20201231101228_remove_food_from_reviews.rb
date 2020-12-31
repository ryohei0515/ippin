class RemoveFoodFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :food, :String
  end
end
