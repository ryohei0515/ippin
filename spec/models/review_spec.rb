require 'rails_helper'

RSpec.describe Review, type: :model do

  let(:review) { build(:review) }

  it "content, food, user_idが全て有効" do
    expect(review).to be_valid
  end

  it "created_atの降順でデータが取得できること" do
    create :review_30_minutes_ago
    create :review_20_minutes_ago
    expect(create(:review_most_recent)).to eq Review.first
  end


  describe "content:" do
    it "空白で無効" do
      expect(build(:review, content: " ")).to_not be_valid
      expect(build(:review, content: nil)).to_not be_valid
    end
    it "長すぎるため無効" do
      expect(build(:review, content: "a" * 400)).to be_valid
      expect(build(:review, content: "a" * 401)).to_not be_valid
    end

  end

  describe "food:" do
    it "空白で無効" do
      expect(build(:review, food: " ")).to_not be_valid
      expect(build(:review, food: nil)).to_not be_valid
    end
    it "長すぎるため無効" do
      expect(build(:review, food: "a" * 50)).to be_valid
      expect(build(:review, food: "a" * 51)).to_not be_valid
    end
  end


  describe "user_id:" do
    it "空白で無効" do
      expect(build(:review, user_id: " ")).to_not be_valid
      expect(build(:review, user_id: nil)).to_not be_valid
    end
  end

end
