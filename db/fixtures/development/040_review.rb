# ユーザーの一部を対象にレビューを生成する
users = User.order(:created_at).take(20)
shops_list = %w[TempShop_1 TempShop_2 TempShop_3 TempShop_4 TempShop_5 TempShop_6 TempShop_7 TempShop_8 TempShop_9 TempShop_10 TempShop_11 TempShop_12 TempShop_13 TempShop_14 TempShop_15 TempShop_16 TempShop_17 TempShop_18 TempShop_19 TempShop_20 TempShop_21 TempShop_22 TempShop_23 TempShop_24 TempShop_25 TempShop_26 TempShop_27 TempShop_28 TempShop_29 TempShop_30 TempShop_31 TempShop_32 TempShop_33 TempShop_34 TempShop_35 TempShop_36 TempShop_37 TempShop_38 TempShop_39 TempShop_40 TempShop_41 TempShop_42 TempShop_43 TempShop_44 TempShop_45 TempShop_46 TempShop_47 TempShop_48 TempShop_49 TempShop_50]

users.each do |user|
  10.times do |i|
    food_id = i + 1
    shop_id = shops_list[Random.rand(0..12)]
    content = Faker::Lorem.sentence(word_count: 10)
    rate = Random.rand(4).to_f + 1
    title = Faker::Lorem.sentence(word_count: 2)
    form = ReviewForm.new({"user_id"=>user.id,
                           "food_id"=>food_id,
                           "content"=>content,
                           "title"=>title,
                           "shop_id"=>shop_id,
                           "rate"=>rate
                          })
    form.create
  end
end

