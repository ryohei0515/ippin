# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { build(:review) }

  it '項目全て有効' do
    expect(review).to be_valid
  end

  it 'updated_atの降順でデータが取得できること' do
    create :review, :created_30_minutes_ago
    rev = create :review, :created_20_minutes_ago
    create :review, :created_10_minutes_ago
    rev.update(content: 'test')
    expect(rev).to eq Review.first
  end

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(400) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { should belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(50) }

  it {
    is_expected.to validate_numericality_of(:rate)
      .is_greater_than_or_equal_to(1)
  }
  it {
    is_expected.to validate_numericality_of(:rate)
      .is_less_than_or_equal_to(5)
  }

  it { is_expected.to validate_presence_of(:shop_food_id) }
  it { should belong_to(:shop_food) }

  it { should have_many(:likes) }
  it do
    should have_many(:liked_users)
      .through(:likes)
      .source(:user)
  end

  it { should delegate_method(:food).to(:shop_food) }
  it { should delegate_method(:shop).to(:shop_food) }
end
