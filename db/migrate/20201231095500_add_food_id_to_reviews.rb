class AddFoodIdToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :food, null: false, foreign_key: true
  end
end
