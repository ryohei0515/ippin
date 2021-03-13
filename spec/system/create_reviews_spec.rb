# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateReviews', type: :system, js: true do
  include LoginSupport
  include AjaxHelper

  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food) }
  before do
    food
    @created_content = 'created_content'
    @created_title = 'created_title'
    @created_rate = 4
    @created_picture = 'test_pic_01.jpg'
  end

  it 'レビューを新規投稿できること' do
    log_in_as user
    visit new_review_path
    expect do
      fill_in '内容', with: @created_content
      fill_in 'タイトル', with: @created_title
      # food選択
      page.find('#food-ddl').click
      page.find('#food-ddl').all('li')[0].click
      # rate選択
      page.find('#review-star-rating').all('img')[@created_rate - 1].click
      # shop選択
      click_link 'お店を選択'
      fill_in 'shop-textbox', with: '鳥'
      click_button '検索'
      wait_for_loaded_until_css_exists('.list')
      page.all('.select-button')[0].click
      @created_shop = find('#review_shop_id', visible: false).value
      # pictureアップロード
      attach_file 'pic_field', file_fixture(@created_picture), make_visible: true
      click_button '新規投稿'
    end.to change(Review, :count).by(1)
    created_review = user.reviews.first
    aggregate_failures do
      expect(created_review.shop_food.food_id).to eq Food.first.id
      expect(created_review.content).to eq @created_content
      expect(created_review.title).to eq @created_title
      expect(created_review.shop_food.shop_id).to eq @created_shop
      expect(created_review.rate).to eq @created_rate
      expect(created_review.picture.file.filename).to eq @created_picture
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_selector '.alert-success'
    end
  end

  describe '入力誤りがある時、投稿されないこと' do
    before do
      log_in_as user
      visit new_review_path
    end
    after do
      expect do
        fill_in '内容', with: @created_content
        fill_in 'タイトル', with: @created_title
        # food選択
        page.find('#food-ddl').click
        page.find('#food-ddl').all('li')[0].click
        # rate選択
        page.find('#review-star-rating').all('img')[@created_rate - 1].click
        # shop選択
        click_link 'お店を選択'
        fill_in 'shop-textbox', with: '鳥'
        click_button '検索'
        wait_for_loaded_until_css_exists('.list')
        page.all('.select-button')[0].click
        click_button '新規投稿'
      end.to change(Review, :count).by(1)
      expect(page).to_not have_selector '.alert-danger'
    end
    it 'foodが未選択' do
      expect do
        fill_in '内容', with: @created_content
        fill_in 'タイトル', with: @created_title
        # rate選択
        page.find('#review-star-rating').all('img')[@created_rate - 1].click
        # shop選択
        click_link 'お店を選択'
        fill_in 'shop-textbox', with: '鳥'
        click_button '検索'
        wait_for_loaded_until_css_exists('.list')
        page.all('.select-button')[0].click
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
      expect(page).to have_selector '.alert-danger'
    end
    it 'contentが未入力' do
      expect do
        fill_in 'タイトル', with: @created_title
        # food選択
        page.find('#food-ddl').click
        page.find('#food-ddl').all('li')[0].click
        # rate選択
        page.find('#review-star-rating').all('img')[@created_rate - 1].click
        # shop選択
        click_link 'お店を選択'
        fill_in 'shop-textbox', with: '鳥'
        click_button '検索'
        wait_for_loaded_until_css_exists('.list')
        page.all('.select-button')[0].click
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
      expect(page).to have_selector '.alert-danger'
    end
    it 'titleが未入力' do
      expect do
        fill_in '内容', with: @created_content
        # food選択
        page.find('#food-ddl').click
        page.find('#food-ddl').all('li')[0].click
        # rate選択
        page.find('#review-star-rating').all('img')[@created_rate - 1].click
        # shop選択
        click_link 'お店を選択'
        fill_in 'shop-textbox', with: '鳥'
        click_button '検索'
        wait_for_loaded_until_css_exists('.list')
        page.all('.select-button')[0].click
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
      expect(page).to have_selector '.alert-danger'
    end
    it 'rateが未選択' do
      expect do
        fill_in '内容', with: @created_content
        fill_in 'タイトル', with: @created_title
        # food選択
        page.find('#food-ddl').click
        page.find('#food-ddl').all('li')[0].click
        # shop選択
        click_link 'お店を選択'
        fill_in 'shop-textbox', with: '鳥'
        click_button '検索'
        wait_for_loaded_until_css_exists('.list')
        page.all('.select-button')[0].click
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
      expect(page).to have_selector '.alert-danger'
    end
    it 'shopが未選択' do
      expect do
        fill_in '内容', with: @created_content
        fill_in 'タイトル', with: @created_title
        # food選択
        page.find('#food-ddl').click
        page.find('#food-ddl').all('li')[0].click
        # rate選択
        page.find('#review-star-rating').all('img')[@created_rate - 1].click
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
      expect(page).to have_selector '.alert-danger'
    end
    it '画像がキャッシュされること' do
      fill_in '内容', with: @created_content
      # food選択
      page.find('#food-ddl').click
      page.find('#food-ddl').all('li')[0].click
      # rate選択
      page.find('#review-star-rating').all('img')[@created_rate - 1].click
      # shop選択
      click_link 'お店を選択'
      fill_in 'shop-textbox', with: '鳥'
      click_button '検索'
      wait_for_loaded_until_css_exists('.list')
      page.all('.select-button')[0].click

      attach_file 'pic_field', file_fixture(@created_picture), make_visible: true
      # Titleが入力されていない状態で投稿
      click_button '新規投稿'
      expect(page).to have_selector("img[src$='#{@created_picture}']")
    end
  end

  it 'TemporaryShopのレビューを新規作成できていること' do
    log_in_as user
    FactoryBot.create(:temporary_shop)
    visit new_review_path
    expect do
      fill_in '内容', with: @created_content
      fill_in 'タイトル', with: @created_title
      # food選択
      page.find('#food-ddl').click
      page.find('#food-ddl').all('li')[0].click
      # rate選択
      page.find('#review-star-rating').all('img')[@created_rate - 1].click
      # shop選択
      click_link 'お店を選択'
      fill_in 'shop-textbox', with: 'test'
      click_button '検索'
      wait_for_loaded_until_css_exists('.list')
      page.all('.select-button')[0].click
      @created_shop = find('#review_shop_id', visible: false).value
      # pictureアップロード
      attach_file 'pic_field', file_fixture(@created_picture), make_visible: true
      click_button '新規投稿'
    end.to change(Review, :count).by(1)
    created_review = user.reviews.first
    aggregate_failures do
      expect(created_review.shop_food.food_id).to eq Food.first.id
      expect(created_review.content).to eq @created_content
      expect(created_review.title).to eq @created_title
      expect(created_review.shop_food.shop_id).to eq @created_shop
      expect(created_review.rate).to eq @created_rate
      expect(created_review.picture.file.filename).to eq @created_picture
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_selector '.alert-success'
    end
  end
end
