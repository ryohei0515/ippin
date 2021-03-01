# frozen_string_literal: true

RSpec.describe ShopFoodSearchForm, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food) }
  let(:shop_food_list) { FactoryBot.create_list(:shop_food, 20) } # 検索対象外のShopFood
  let(:shop_food_target_list_food) { FactoryBot.create_list(:shop_food, 10, food: food) } # 検索対象のShopFood（food指定）
  let(:shop_food_target_list_large_area) { FactoryBot.create_list(:shop_food_specific_large_area, 3, food: food) } # 検索対象のShopFood（food、large_area指定）
  let(:shop_food_target_list_middle_area) { FactoryBot.create_list(:shop_food_specific_middle_area, 2, food: food) }  # 検索対象のShopFood（food、middle_area指定）

  it { is_expected.to validate_presence_of(:food_id) }

  describe '#search' do
    describe '検索条件に合致したShopFoodを検索できること' do
      it 'food_idを指定' do
        shop_food_list
        shop_food_target_list_food
        form = ShopFoodSearchForm.new({ 'food_id' => food.id })
        result = form.search
        expect(result.count).to eq 10
      end
      it 'large_areaを指定' do
        shop_food_list
        shop_food_target_list_large_area
        form = ShopFoodSearchForm.new({ 'food_id' => food.id,
                                        'large_area' => shop_food_target_list_large_area[0].shop.large_area })
        result = form.search
        expect(result.count).to eq 3
      end
      it 'middle_areaを指定' do
        shop_food_list
        shop_food_target_list_middle_area
        form = ShopFoodSearchForm.new({ 'food_id' => food.id,
                                        'large_area' => shop_food_target_list_middle_area[0].shop.large_area,
                                        'middle_area' => shop_food_target_list_middle_area[0].shop.middle_area })
        result = form.search
        expect(result.count).to eq 2
      end
    end
  end
end
