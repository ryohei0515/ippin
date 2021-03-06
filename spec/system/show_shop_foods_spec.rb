# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShowShopFoods', type: :system, js: true do
  include ActionView::Helpers::DateHelper
  include ApiHelper

  let(:review_list) { FactoryBot.create_list(:review, Settings.kaminari.per.review + 5, :picture, shop_food: shop_food) }
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
      shop = get_shop_info(shop_food.shop_id)
      expect(page).to have_content shop['name']
      expect(page).to have_content shop['genre']['name']
      expect(page).to have_content shop['mobile_access'].strip_all_space!
      expect(page).to have_content shop['address'].strip_all_space!
      expect(page).to have_content "#{shop['capacity']}席"
      expect(page).to have_content shop_food.rate
      expect(page).to have_content "#{shop_food.reviews.count}件"
      expect(page).to have_selector '.pagination'
      shop_food.reviews[0..Settings.kaminari.per.review - 1].each do |review|
        expect(page).to have_content review.title
        expect(page).to have_content review.content
        expect(page).to have_selector("div.star-rating[data-rate='#{review.rate}']")
        expect(page).to have_content review.user.name
        expect(page).to have_selector("img[src$='#{review.picture_url}']")
        expect(page).to have_content review.created_at.strftime('%Y/%-m/%-d')
        expect(page).to have_content review.updated_at.strftime('%Y/%-m/%-d')
        expect(page).to have_content "#{review.liked_users.count}人"
      end
    end
  end
end
