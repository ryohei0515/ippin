# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShowFoods', type: :system, js: true do
  include ActionView::Helpers::DateHelper
  include ApiHelper

  let(:review_list) { FactoryBot.create_list(:review, 10, :picture, food: food) }
  let(:food) { FactoryBot.create(:food) }

  it '正しくfoodとそれに紐づくReviewを表示できること' do
    review_list
    visit food_path(food.id)
    aggregate_failures do
      expect(page).to have_content food.name
      expect(page).to have_content get_shop_info(food.shop)['name']
      expect(page).to have_content food.category
      expect(page).to have_selector("div.star-rating[data-rate='#{food.rate}']")
      expect(page).to have_content "#{food.reviews.count}件"
      expect(page).to have_selector '.pagination'
      food.reviews.order(rate: :desc)[0..4] do |review|
        expect(page).to have_content review.title
        expect(page).to have_content review.content
        expect(page).to have_selector("div.star-rating[data-rate='#{review.rate}']")
        expect(page).to have_content review.user.name
        expect(page).to have_selector("img[src$='#{review.picture_url(:thumb)}']")
        expect(page).to have_content review.updated_at.strftime('%Y年%-m月%-d日')
      end
    end
  end
end
