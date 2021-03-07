require 'csv'

file_path = "db/fixtures/#{Rails.env}/csv/food.csv"

CSV.foreach(file_path, encoding: 'UTF-8', headers: :first_row) do |r|
  Food.seed(:id) do |s|
    s.id = r['id']
    s.name = r['name']
    s.name_kana = r['name_kana']
    s.category = r['category']
    s.description= r['description']
  end
end