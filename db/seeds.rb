# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# ユーザーの一部を対象にレビューを生成する
users = User.order(:created_at).take(6)
shops_list = ['J001170499','J001041354','J001217325','J001170779','J000650214','J001131650','J001187056','J001027648','J001028629','J001184908']

users.each do |user|
  10.times do |i|
    name = "Food_#{i}"
    category = "Category_#{i}"
    shop = shops_list[Random.rand(0..9)]
    content = Faker::Lorem.sentence(word_count: 5)
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

  if user.name == "Example User"
    100.times do |i|
      name = "Food_#{i+10}"
      category = "Category_#{i+10}"
      shop = shops_list[Random.rand(0..9)]
      content = Faker::Lorem.sentence(word_count: 5)
      rate = 1
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
end

