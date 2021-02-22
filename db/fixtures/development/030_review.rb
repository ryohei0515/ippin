# ユーザーの一部を対象にレビューを生成する
users = User.order(:created_at).take(20)
shops_list = ['J001170499','J001041354','J001217325']

users.each do |user|
  10.times do |i|
    name = "Food_#{i}"
    category = "Category_#{i}"
    shop = shops_list[Random.rand(0..2)]
    content = Faker::Lorem.sentence(word_count: 10)
    rate = Random.rand(4).to_f + 1
    title = Faker::Lorem.sentence(word_count: 2)
    form = ReviewForm.new({"user_id"=>user.id,
                           "food"=>name,
                           "content"=>content,
                           "title"=>title,
                           "shop"=>shop,
                           "rate"=>rate,
                           "category"=>category
                          })
    form.create
  end
end

