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

users.each do |user|
  10.times do |i|
    name = "Food_#{i}"
    category = "Category_#{i}"
    restaurant = "Restaurant_#{i}"
    content = Faker::Lorem.sentence(word_count: 5)
    rate = Random.rand(8).to_f / 2 + 1
    title = Faker::Lorem.sentence(word_count: 2)
    form = ReviewForm.new({"user_id"=>user.id,
                           "food"=>name,
                           "content"=>content,
                           "title"=>title,
                           "restaurant"=>restaurant,
                           "rate"=>rate,
                           "category"=>category
                          })
    form.create
  end
end
