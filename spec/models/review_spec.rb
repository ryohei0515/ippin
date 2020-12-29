require 'rails_helper'

RSpec.describe Review, type: :model do

  let(:review) { build(:review) }

  it "content, food, user_idが全て有効" do
    expect(review).to be_valid
  end

  it "created_atの降順でデータが取得できること" do
    create :review, :created_30_minutes_ago
    create :review, :created_20_minutes_ago
    expect(create(:review, :created_most_recent)).to eq Review.first
  end

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(400) }

  it { is_expected.to validate_presence_of(:food) }
  it { is_expected.to validate_length_of(:food).is_at_most(50) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { should belong_to(:user) }
end
