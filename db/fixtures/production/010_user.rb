require 'csv'

file_path = "db/fixtures/#{Rails.env}/csv/user.csv"

CSV.foreach(file_path, encoding: 'UTF-8', headers: :first_row) do |r|
  User.seed(:id) do |s|
    s.id = r['id']
    s.email = r['email']
    s.name = r['name']
    s.password = r['password']
    s.password_confirmation = r['password']
    s.picture = Rails.root.join("db/fixtures/resource/temp_picture/#{r['picture']}").open if r['picture'].present?
  end
end