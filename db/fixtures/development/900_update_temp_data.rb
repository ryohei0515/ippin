require 'csv'

# ポートフォリオ用のReview用画像データ登録用。
class UpdateTempData
  def self.exec
    use_count = 5 # 1枚の画像につき、何reviewで使用するか設定

    use_pic_limit = {}
    Food.all.each do |food|
      use_pic_limit[food.id] = 0
    end

    pictures = {}
    review_file_path = "db/fixtures/#{Rails.env}/csv/review__picture.csv"
    CSV.foreach(review_file_path, encoding: 'UTF-8', headers: :first_row) do |r|
      food_id = r['food_id'].to_i
      pictures[food_id] = [] unless pictures.key?(food_id)
      pictures[food_id] << { picture: "#{Rails.root}/db/fixtures/resource/temp_picture/#{r['picture']}",
                             picture_cc: r['picture_cc'] }
      use_pic_limit[food_id] += use_count
    end

    start_date = Date.parse("2020/09/01")
    end_date = Date.parse("2021/03/01")
    Review.all.each do |rev|
      created_date = Random.rand(start_date .. end_date)
      updated_date = created_date
      updated_date += rand(1..15) if rand(1..4) == 1 # 一部データの更新日を変更する。
      food_id = rev.shop_food.food_id
      # rateが高く、画像の使用制限を超えていないときのみ登録する
      if use_pic_limit[food_id] > 0 && rev.rate >= 4
        num = use_pic_limit[food_id] % use_count
        rev.update(created_at: created_date, updated_at: updated_date,
                   picture: open(pictures[food_id][num][:picture]),
                   picture_cc: pictures[food_id][num][:picture_cc])
        use_pic_limit[food_id] -= 1
      else
        rev.update(created_at: created_date, updated_at: updated_date,
                   picture: nil, picture_cc: nil)
      end
    end
  end
end

UpdateTempData.exec