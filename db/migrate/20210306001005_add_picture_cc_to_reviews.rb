class AddPictureCcToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :picture_cc, :string
  end
end
