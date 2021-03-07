require 'csv'

# ポートフォリオ用のサンプルデータ作成用。
# User   :ユーザ画像の登録 
# Review :レビュー画像登録、作成日・更新日の変更。
# seed_fuでは以下のコードが実行できないため、コンソール上から下記の処理を実行する。
# $ load "./db/fixtures/development/900_update_temp_data.rb"
# $ update_temp_data
def update_temp_data
  # User更新
  User.all.each do |user|
    user.update(picture: open("#{Rails.root}/db/fixtures/resource/temp_picture/#{user.picture}")) if user.picture.present?
  end

  # Review更新
  file_path = "db/fixtures/#{Rails.env}/csv/review__picture.csv"
  use_count = 5 # 1枚の画像につき、何reviewで使用するか設定

  use_pic_limit = {}
  Food.all.each do |food|
    use_pic_limit[food.id] = 0
  end

  pictures = {}
  CSV.foreach(file_path, encoding: 'UTF-8', headers: :first_row) do |r|
    food_id = r['food_id'].to_i
    pictures[food_id] = [] unless pictures.key?(food_id)
    pictures[food_id] << { picture: "#{Rails.root}/db/fixtures/resource/temp_picture/#{r['picture']}",
                           picture_cc: r['picture_cc'] }
    use_pic_limit[food_id] += use_count
  end

  start_date = Date.parse("2020/09/01")
  end_date = Date.parse("2021/03/01")
  Review.all.each do |rev|
    date = Random.rand(start_date .. end_date)
    food_id = rev.shop_food.food_id
    # rateが低いときは画像を登録しないように
    if use_pic_limit[food_id] > 0 && rev.rate >= 4
      num = use_pic_limit[food_id] % use_count
      rev.update(created_at: date, updated_at: date,
                 picture: open(pictures[food_id][num][:picture]),
                 picture_cc: pictures[food_id][num][:picture_cc])
      use_pic_limit[food_id] -= 1
    else
      rev.update(created_at: date, updated_at: date)
    end
  end
end