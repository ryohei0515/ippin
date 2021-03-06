# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  include LoginSupport
  include ApiHelper

  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food) }
  let(:shop_food_list) { FactoryBot.create_list(:shop_food, 20) } # 検索対象外のShopFoodを生成
  let(:shop_food_target_list) { FactoryBot.create_list(:shop_food, Settings.kaminari.per.shop_food + 5, food: food) } # 検索対象とするShopFoodを生成
  let(:review_list) { FactoryBot.create_list(:review, Settings.kaminari.per.review + 5) }

  it 'Foodの検索条件に合致したShopの情報が表示されること', js: true do
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

  it 'ホーム画面のログインフォームよりログインできること' do
    visit root_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(page).to have_selector 'a', text: 'ログアウト'
      expect(page).to_not have_selector 'a', text: 'ログイン'
    end
  end

  it 'ホーム画面よりゲストログインできること' do
    FactoryBot.create(:sample_user)
    visit root_path
    click_button 'ゲストログイン'

    aggregate_failures do
      expect(current_path).to eq user_path(Settings.sample_user.id)
      expect(page).to have_selector 'a', text: 'ログアウト'
      expect(page).to_not have_selector 'a', text: 'ログイン'
    end
  end

  it 'ログイン時、ホーム画面にログインフォームが表示されないこと' do
    log_in_as user
    visit root_path

    expect(page).to_not have_button 'ログイン'
    expect(page).to_not have_button 'ゲストログイン'
  end

  it 'ホーム画面に更新日の降順でレビューが表示されること' do
    review_list
    visit root_path

    aggregate_failures do
      expect(page).to have_content "#{Review.count}件"
      expect(page).to have_selector '.pagination'
      review_list[0..Settings.kaminari.per.review - 1].each do |review|
        shop = get_shop_info(review.shop.id)
        expect(page).to have_content shop['name']
        expect(page).to have_content review.food.name
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
