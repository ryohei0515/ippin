# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShowShopFoods', type: :system, js: true do
  include ActionView::Helpers::DateHelper
  include ApiHelper

  let(:review_list) { FactoryBot.create_list(:review, 10, :picture, shop_food: shop_food) }
  let(:shop_food) { FactoryBot.create(:shop_food) }

  before do
    review_list.each do |review|
      Random.rand(2..10).times do
        FactoryBot.create(:like, review: review)
      end
    end
  end

  it '正しくShopFoodとそれに紐づくReviewを表示できること' do
    review_list
    visit shop_food_path(shop_food.id)
    aggregate_failures do
      expect(page).to have_content shop_food.food.name
      expect(page).to have_content get_shop_info(shop_food.shop_id)['name']
      expect(page).to have_content shop_food.food.category
      expect(page).to have_selector("div.star-rating[data-rate='#{shop_food.rate}']")
      expect(page).to have_content "#{shop_food.reviews.count}件"
      expect(page).to have_selector '.pagination'
      shop_food.reviews[0..4].each do |review|
        expect(page).to have_content review.title
        expect(page).to have_content review.content
        expect(page).to have_selector("div.star-rating[data-rate='#{review.rate}']")
        expect(page).to have_content review.user.name
        expect(page).to have_selector("img[src$='#{review.picture_url(:thumb)}']")
        expect(page).to have_content review.updated_at.strftime('%Y年%-m月%-d日')
        expect(page).to have_content "#{review.liked_users.count}人"
      end
    end
  end
end
