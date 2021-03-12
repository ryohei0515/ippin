# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserProfiles', type: :system do
  include ApiHelper
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:review_list) { FactoryBot.create_list(:review, 30, user: user) }

  it 'ユーザ詳細ページが正しく表示されること' do
    review_list
    visit user_path(user.id)
    aggregate_failures do
      expect(page).to have_content user.name
      expect(page).to have_selector("img[src$='#{user.picture_url(:thumb)}']")
      expect(page).to have_content "#{user.reviews.count}件"
      expect(page).to have_selector '.pagination'
      review_list[0..4].each do |review|
        shop = get_shop_info(review.shop.id)
        expect(page).to have_content shop['name']
        expect(page).to have_content review.food.name
        expect(page).to have_content review.title
        expect(page).to have_content review.content
        expect(page).to have_selector("div.star-rating[data-rate='#{review.rate}']")
        expect(page).to have_content review.user.name
        expect(page).to have_selector("img[src$='#{review.picture_url}']")
        expect(page).to have_content review.updated_at.strftime('%Y年%-m月%-d日')
        expect(page).to have_content "#{review.liked_users.count}人"
      end
    end
  end

  it '他ユーザのレビューが表示されないこと' do
    review_list
    other_user_review = FactoryBot.create(:review, :created_30_minutes_ago,
                                          user: other_user)
    visit user_path(user.id)
    expect(page).to_not have_content other_user_review.content
  end
end
