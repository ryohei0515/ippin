# ユーザーの一部を対象にレビューを生成する
users = User.order(:created_at).take(20)
shops_list = ['J001170499','J001041354','J001217325']

users.each do |user|
  5.times do |i|
    food_id = i + 1
    shop = shops_list[Random.rand(0..2)]
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

