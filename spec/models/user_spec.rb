require 'rails_helper'

RSpec.describe User, type: :model do

  it "name、email、passwordが全て有効" do
    expect(build(:user)).to be_valid
  end

  describe "name:" do
    it "空白で無効" do
      expect(build(:user, name: " ")).to_not be_valid
      expect(build(:user, name: nil)).to_not be_valid
    end
    it "長すぎるため無効" do
      expect(build(:user, name: "a" * 50)).to be_valid
      expect(build(:user, name: "a" * 51)).to_not be_valid
    end
  end

  describe "email:" do
    it "空白で無効" do
      expect(build(:user, email: " ")).to_not be_valid
      expect(build(:user, email: nil)).to_not be_valid
    end
    it "長すぎるため無効" do
      expect(build(:user, email: "a" * 243 + "@example.com")).to be_valid
      expect(build(:user, email: "a" * 244 + "@example.com")).to_not be_valid
    end
    describe "フォーマットに則っていないため無効" do
      it "user@example,com" do
        expect(build(:user, email: "user@example,com")).to_not be_valid
      end
      it "user_at_foo.org" do
        expect(build(:user, email: "user_at_foo.org")).to_not be_valid
      end
      it "user.name@example." do
        expect(build(:user, email: "user.name@example.")).to_not be_valid
      end
      it "foo@bar_baz.com" do
        expect(build(:user, email: "foo@bar_baz.com")).to_not be_valid
      end
      it "foo@bar+baz.com" do
        expect(build(:user, email: "foo@bar+baz.com")).to_not be_valid
      end
    end
    it "他ユーザと重複しているため無効" do
      create(:user)
      user = build(:user)
      expect(user).to_not be_valid
      user.email = "other@example.com"
      expect(user).to be_valid
    end
  end

  describe "password:" do
    it "空白で無効" do
      expect(build(:user, password: " ", password_confirmation: " "))
              .to_not be_valid
      expect(build(:user, password: nil, password_confirmation: nil))
              .to_not be_valid
    end
    it "短すぎるため無効" do
      expect(build(:user, password: "a" * 6, password_confirmation: "a" * 6))
              .to be_valid
      expect(build(:user, password: "a" * 5, password_confirmation: "a" * 5))
              .to_not be_valid
    end
  end

  describe "#authenticated?" do
    it "引数がnilの時、falseを返すこと" do
      expect(build(:user).authenticated?(nil)).to be_falsey
    end
  end

  it "ユーザを削除した時、レビューも併せて削除されること" do
    user = create(:user)
    FactoryBot.create(:review, user: user)
    expect{ user.destroy }.to change{ Review.count }.by(-1)
  end

end
