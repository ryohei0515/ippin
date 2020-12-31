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
    name = Faker::Food.dish
    category = "Category_#{i}"
    restaurant = "Restaurant_#{i}"
    food = Food.create!(name: name,
                        category: category,
                        restaurant: restaurant
                       )

    content = Faker::Lorem.sentence(word_count: 5)
    restaurant = Faker::Restaurant.name
    rate = Random.rand(8).to_f / 2 + 1
    title = Faker::Lorem.sentence(word_count: 2)
    user.reviews.create!(content: content,
                         food: food,
                         restaurant: restaurant,
                         rate: rate,
                         title: title
                        )
  end
end
