# メインのサンプルユーザーを1人作成する
User.seed(:email) do |s|
  s.name = "Example User"
  s.email = "example@railstutorial.org"
  s.password = "foobar"
  s.password_confirmation = "foobar"
end

# 追加のユーザーをまとめて生成する
30.times do |n|
  User.seed(:email) do |s|
    s.name = Faker::Name.name
    s.email = "example-#{n+1}@railstutorial.org"
    s.password = "password"
    s.password_confirmation = "password"
  end
end