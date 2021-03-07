require 'csv'

file_path = "db/fixtures/#{Rails.env}/csv/review.csv"

CSV.foreach(file_path, encoding: 'UTF-8', headers: :first_row) do |r|
  form = ReviewForm.new({"user_id"=>r['user_id'],
                         "food_id"=>r['food_id'],
                         "content"=>r['content'],
                         "title"=>r['title'],
                         "shop_id"=>r['shop_id'],
                         "rate"=>r['rate']
                        })
  form.create
end