# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it { should have_many(:reviews) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(30) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:restaurant).case_insensitive }

  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_length_of(:category).is_at_most(15) }

  it { is_expected.to validate_presence_of(:restaurant) }
  it { is_expected.to validate_length_of(:restaurant).is_at_most(50) }

  it 'rateの降順でデータが取得できること' do
    FactoryBot.create :food, rate: 3
    FactoryBot.create :food, rate: 2
    expect(FactoryBot.create(:food, rate: 4)).to eq Food.first
  end

  describe '#calc_and_save_rate' do
    let(:food) do
      FactoryBot.create(:food, name: 'test_name',
                               restaurant: 'restaurant', rate: 0)
    end

    it 'foodのrateを正しく更新できること' do
      sum_rate = 0
      5.times do
        review = FactoryBot.create(:review, user: user, food: food,
                                            rate: Random.rand(8).to_f / 2 + 1)
        sum_rate += review.rate
      end
      food.calc_and_save_rate
      expect(food.rate).to eq (sum_rate / 5).round(2)
    end
    context '紐づくreviewがない場合' do
      it 'rateを更新しないこと' do
        expect(food.calc_and_save_rate).to be_falsey
        expect(food.rate).to eq 0
      end
    end
  end
end
