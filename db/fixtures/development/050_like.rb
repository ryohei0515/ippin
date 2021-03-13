sample_user_count = 41 # サンプル用に作成したユーザの数
rate = rand(0..35) # likeに登録する割合

users = User.where("id <= #{sample_user_count} and id != #{Settings.sample_user.id}")
Review.all.each do |review|
  users.each do |user|
    next if rand(1..100) > rate || review.user_id == user.id
    Like.seed do |s|
      s.user_id = user.id
      s.review_id = review.id
    end
  end
end
