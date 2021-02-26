# ユーザーの一部を対象にレビューを生成する
users = User.order(:created_at).take(20)
shops_list = %w[J001170499 J001041354 J001217325 J001259384 J001233764 J001249396 J000133890 J001145797 J001261533 J001192710 J001262652 J001232591 J001098481]

users.each do |user|
  10.times do |i|
    food_id = i + 1
    shop = shops_list[Random.rand(0..12)]
    content = Faker::Lorem.sentence(word_count: 10)
    rate = Random.rand(4).to_f + 1
    title = Faker::Lorem.sentence(word_count: 2)
    form = ReviewForm.new({"user_id"=>user.id,
                           "food_id"=>food_id,
                           "content"=>content,
                           "title"=>title,
                           "shop"=>shop,
                           "rate"=>rate
                          })
    form.create
  end
end

