# frozen_string_literal: true

RSpec.describe ShopFoodSearchForm, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food) }
  let(:shop_food_list) { FactoryBot.create_list(:shop_food, 20) }
  let(:shop_food_target_list) { FactoryBot.create_list(:shop_food, 5, food: food) }
  it { is_expected.to validate_presence_of(:food_id) }

  describe '#search' do
    xit '検索条件に合致したShopFoodを検索できること' do
      shop_food_list
      shop_food_target_list  # 検索対象とするShopFoodを生成
      form = ShopFoodSearchForm({ 'food_id' => food.id })
      result = form.search
      expect(result.count).to eq 5
      expect(result.where(food_id: food.id).count).to eq 5
    end
  end
end
