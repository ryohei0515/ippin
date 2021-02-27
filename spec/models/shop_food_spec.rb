# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShopFood, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it { should have_many(:reviews) }

  it { should belong_to(:food) }
  it { is_expected.to validate_presence_of(:food_id) }

  it { should belong_to(:shop) }
  it { is_expected.to validate_presence_of(:shop_id) }

  it 'rateの降順でデータが取得できること' do
    FactoryBot.create :shop_food, rate: 3
    FactoryBot.create :shop_food, rate: 2
    expect(FactoryBot.create(:shop_food, rate: 4)).to eq ShopFood.first
  end

  describe '#calc_and_save_rate' do
    let(:shop_food) { FactoryBot.create(:shop_food, rate: 0) }

    it 'shop_foodのrateを正しく更新できること' do
      sum_rate = 0
      5.times do
        review = FactoryBot.create(:review, user: user, shop_food: shop_food,
                                            rate: Random.rand(8).to_f / 2 + 1)
        sum_rate += review.rate
      end
      shop_food.calc_and_save_rate
      expect(shop_food.rate).to eq (sum_rate / 5).round(2)
    end
    context '紐づくreviewがない場合' do
      it 'rateを更新しないこと' do
        expect(shop_food.calc_and_save_rate).to be_falsey
        expect(shop_food.rate).to eq 0
      end
    end
  end
end
