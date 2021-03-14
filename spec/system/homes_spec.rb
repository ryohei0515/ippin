# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :system, js: true do
  include ApiHelper

  let(:food) { FactoryBot.create(:food) }
  let(:shop_food_list) { FactoryBot.create_list(:shop_food, 20) } # 検索対象外のShopFoodを生成
  let(:shop_food_target_list) { FactoryBot.create_list(:shop_food, Settings.kaminari.per.shop_food + 5, food: food) } # 検索対象とするShopFoodを生成

  it 'Foodの検索条件に合致したShopの情報が表示されること' do
    shop_food_target_list
    shop_food_list
    visit root_path
    # food選択
    page.find('#food-ddl').click
    page.find('#food-ddl').all('li')[0].click # 1件目選択
    click_button '検索'
    result = ShopFood.where(food_id: food.id)
    aggregate_failures do
      expect(page).to have_content "#{result.count}件"
      expect(page).to have_selector '.pagination'
      result.order('rate desc, shop_foods.updated_at desc')[0..Settings.kaminari.per.shop_food - 1].each do |shop_food|
        shop = get_shop_info(shop_food.shop_id)
        expect(page).to have_content shop['name']
        expect(page).to have_content shop['genre']['name']
        expect(page).to have_content shop['mobile_access'].strip_all_space!
        expect(page).to have_content shop['address'].strip_all_space!
        expect(page).to have_content "#{shop['capacity']}席"
        expect(page).to have_content shop_food.rate
        expect(page).to have_content "#{shop_food.reviews.count}件"
      end
    end
  end
end
