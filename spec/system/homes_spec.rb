# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  include ApiHelper

  let(:user) { FactoryBot.create(:user) }
  let(:review_list) { FactoryBot.create_list(:review, 30, user: user) }
  let(:food_list) { FactoryBot.create_list(:food, 30) }

  it 'ホーム画面のFoodが正しく表示されること' do
    food_list
    visit root_path
    aggregate_failures do
      expect(page).to have_content "#{Food.count}件"
      expect(page).to have_selector '.pagination'
      Food.all.order(rate: :desc, name: :asc)[0..4].each do |food|
        expect(page).to have_content food.name
        expect(page).to have_content get_shop_info(food.shop)['name']
        expect(page).to have_content food.category
        expect(page).to have_content food.rate
      end
    end
  end
end
