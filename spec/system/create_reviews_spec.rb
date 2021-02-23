# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateReviews', type: :system, js: true do
  include LoginSupport
  include AjaxHelper

  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food) }
  before do
    @created_food_id = food.id
    @created_content = 'created_content'
    @created_title = 'created_title'
    @created_shop = ''
    @created_rate = 4
    @created_picture = 'test_pic_01.jpg'
  end

  it 'レビューを新規投稿できること' do
    log_in_as user
    visit new_review_path
    expect do
      fill_in 'Content', with: @created_content
      fill_in 'Food', with: @created_food_id
      fill_in 'Title', with: @created_title
      # rate入力
      page.find('#review-star-rating').all('img')[@created_rate - 1].click
      # shop選択
      click_link 'お店を選択'
      fill_in 'shop-textbox', with: '鳥'
      click_button '検索'
      wait_for_loaded_until_css_exists('.select-button')
      page.all('.select-button')[0].click
      @created_shop = find('#review_shop', visible: false).value
      # pictureアップロード
      attach_file 'Picture', file_fixture(@created_picture)
      click_button '新規投稿'
    end.to change(Review, :count).by(1)
    created_review = user.reviews.first
    aggregate_failures do
      expect(created_review.shop_food.food_id).to eq @created_food_id
      expect(created_review.content).to eq @created_content
      expect(created_review.title).to eq @created_title
      expect(created_review.shop_food.shop).to eq @created_shop
      expect(created_review.rate).to eq @created_rate
      expect(created_review.picture.file.filename).to eq @created_picture
      expect(current_path).to eq review_path(created_review.id)
    end
  end

  describe '入力誤りがある時、投稿されないこと' do
    before do
      log_in_as user
      visit new_review_path
      fill_in 'Content', with: @created_content
      fill_in 'Food', with: @created_food_id
      fill_in 'Title', with: @created_title
    end
    after do
      expect do
        fill_in 'Content', with: @created_content
        fill_in 'Food', with: @created_food_id
        fill_in 'Title', with: @created_title
        # shop選択
        click_link 'お店を選択'
        fill_in 'shop-textbox', with: '鳥'
        click_button '検索'
        wait_for_loaded_until_css_exists('.select-button')
        page.all('.select-button')[0].click
        page.find('#review-star-rating').all('img')[@created_rate - 1].click
        click_button '新規投稿'
      end.to change(Review, :count).by(1)
    end
    describe 'shop以外のチェック' do
      before do
        # shop選択
        click_link 'お店を選択'
        fill_in 'shop-textbox', with: '鳥'
        click_button '検索'
        wait_for_loaded_until_css_exists('.select-button')
        page.all('.select-button')[0].click
        @created_shop = find('#review_shop', visible: false).value
      end
      it 'foodが誤り' do
        expect do
          page.find('#review-star-rating').all('img')[@created_rate - 1].click
          fill_in 'Food', with: ''
          click_button '新規投稿'
        end.to change(Review, :count).by(0)
      end
      it 'contentが誤り' do
        expect do
          page.find('#review-star-rating').all('img')[@created_rate - 1].click
          fill_in 'Content', with: ''
          click_button '新規投稿'
        end.to change(Review, :count).by(0)
      end
      it 'titleが誤り' do
        expect do
          page.find('#review-star-rating').all('img')[@created_rate - 1].click
          fill_in 'Title', with: ''
          click_button '新規投稿'
        end.to change(Review, :count).by(0)
      end
      it 'rateが誤り' do
        expect do
          # Rateが入力されていない状態で投稿
          click_button '新規投稿'
        end.to change(Review, :count).by(0)
      end
      it '画像がキャッシュされること' do
        attach_file 'Picture', file_fixture(@created_picture)
        # Rateが入力されていない状態で投稿
        click_button '新規投稿'
        expect(page).to have_selector("img[src$='thumb_#{@created_picture}']")
      end
    end
    it 'shopが未選択' do
      expect do
        page.find('#review-star-rating').all('img')[@created_rate - 1].click
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
    end
  end
end
