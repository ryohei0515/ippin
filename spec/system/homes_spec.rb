# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  include ApiHelper

  let(:user) { FactoryBot.create(:user) }
  let(:review_list) { FactoryBot.create_list(:review, 30, user: user) }
  let(:shop_food_list) { FactoryBot.create_list(:shop_food, 30) }

  it 'ホーム画面のShopFoodが正しく表示されること' do
    shop_food_list
    visit root_path
    aggregate_failures do
      expect(page).to have_content "#{ShopFood.count}件"
      expect(page).to have_selector '.pagination'
      ShopFood.all.order(rate: :desc, name: :asc)[0..4].each do |shop_food|
        expect(page).to have_content shop_food.food.name
        expect(page).to have_content get_shop_info(shop_food.shop)['name']
        expect(page).to have_content shop_food.food.category
        expect(page).to have_content shop_food.rate
      end
    end
  end
end
