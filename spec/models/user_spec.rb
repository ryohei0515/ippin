require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、メールアドレス、パスワードが全て有効" do
    expect{ build(:user).to be_valid }
  end

  it "名前が空白で無効" do
    expect{ build(:user, name: " ").to_not be_valid }
    expect{ build(:user, name: nil).to_not be_valid }
  end

  it "メールアドレスが空白で無効" do
    expect{ build(:user, email: " ").to_not be_valid }
    expect{ build(:user, email: nil).to_not be_valid }
  end

  it "パスワードが空白で無効" do
    expect{ build(:user, password: " ").to_not be_valid }
    expect{ build(:user, password: nil).to_not be_valid }
  end

  it "名前が長すぎるため無効" do
    expect{ build(:user, name: "a" * 50).to be_valid }
    expect{ build(:user, name: "a" * 51).to_not be_valid }
  end

  it "メールアドレスが長すぎるため無効" do
    expect{ build(:user, email: "a" * 243 + "@example.com").to be_valid }
    expect{ build(:user, email: "a" * 244 + "@example.com").to_not be_valid }
  end

  it "パスワードが短すぎるため無効" do
    expect{ build(:user, password: "a" * 6, password_confirmation: "a" * 6)
            .to be_valid }
    expect{ build(:user, password: "a" * 5, password_confirmation: "a" * 5)
            .to_not be_valid }
  end

  it "メールアドレスのフォーマットに則っていないため無効" do
    expect{ build(:user, email: "user@example,com").to_not be_valid }
    expect{ build(:user, email: "user_at_foo.org").to_not be_valid }
    expect{ build(:user, email: "user.name@example.").to_not be_valid }
    expect{ build(:user, email: "foo@bar_baz.com").to_not be_valid }
    expect{ build(:user, email: "foo@bar+baz.com").to_not be_valid }
  end

  it "メールアドレスが他ユーザと重複しているため無効" do
    create(:user)
    expect{ build(:user).to_not be_valid }
  end

  it "authenticated?の引数がnilの時、falseを返すこと" do
    expect{ build(:user).authenticated?(nil).to be_falsey }
  end

  it "ユーザを削除した時、レビューも併せて削除されること" do
    user = create(:user)
    user.reviews.create!(content: "おいしい", food: "ハンバーグ")
    expect{ user.destroy.to change{ Review.count }.by(-1) }
  end

end
