# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'IndexShopFoods', type: :system do
  include ApiHelper

  let(:user) { FactoryBot.create(:user) }
  let(:review_list) { FactoryBot.create_list(:review, 30, user: user) }
  let(:shop_food_list) { FactoryBot.create_list(:shop_food, 30) }

  xit 'Foodの検索条件に合致したShopの情報が表示されること' do
    shop_food_list
    visit shop_foods_path
    # food選択
    page.find('#food-ddl').click
    page.find('#food-ddl').all('li')[0].click # 1件目選択
    click_button '検索'
    aggregate_failures do
      expect(page).to have_content "#{ShopFood.count}件"
      expect(page).to have_selector '.pagination'
      ShopFood.where(food_id: Food.first.id).order('rate desc, shop_foods.updated_at desc')[0..4].each do |shop_food|
        expect(page).to have_content shop_food.food.name
        expect(page).to have_content get_shop_info(shop_food.shop)['name']
        expect(page).to have_content shop_food.food.category
        expect(page).to have_content shop_food.rate
      end
    end
  end

  xit 'Foodの検索条件が未入力時、エラーとなること。' do
    shop_food_list
    visit shop_foods_path

    click_button '検索'
    expect(page).to have_selector '.alert-danger'
    expect(page).to have_content '0件'
    expect(page).to_not have_selector '.pagination'
  end
end
