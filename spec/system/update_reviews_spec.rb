# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UpdateReviews', type: :system, js: true do
  include LoginSupport
  include ApiHelper
  include AjaxHelper

  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food) }
  let(:review) { FactoryBot.create(:review, user: user) }
  before do
    food
    @updated_content = 'updated_content'
    @updated_title = 'updated_title'
    @updated_rate = 4
    @updated_picture = 'test_pic_02.jpg'
  end

  it '正しく初期表示できていること' do
    log_in_as user
    rev = FactoryBot.create(:review, :picture, user: user)
    visit edit_review_path(rev.id)
    aggregate_failures do
      expect(page).to have_selector "input[value='#{rev.title}']"
      expect(page).to have_selector "#review-star-rating[data-rate='#{rev.rate}']"
      expect(page).to have_content rev.shop_food.food.name
      expect(page).to have_content get_shop_info(rev.shop_food.shop_id)['name']
      expect(page).to have_selector "img[src$='#{rev.picture.filename}']"
      expect(page).to have_content rev.content
    end
  end

  it 'ログインユーザ自身のレビューを更新できること' do
    log_in_as user
    visit edit_review_path(review.id)
    fill_in '内容', with: @updated_content
    fill_in 'タイトル', with: @updated_title
    # food選択
    page.find('#food-ddl').click
    page.find('#food-ddl').all('li')[0].click
    # rate選択
    page.find('#review-star-rating').all('img')[@updated_rate - 1].click
    # shop選択
    click_link 'お店を選択'
    fill_in 'shop-textbox', with: '鳥'
    click_button '検索'
    wait_for_loaded_until_css_exists('.list')
    page.all('.select-button')[0].click
    updated_shop = find('#review_shop_id', visible: false).value
    attach_file 'pic_field', file_fixture(@updated_picture), make_visible: true
    click_button '修正する'
    updated_review = Review.find(review.id)
    aggregate_failures do
      expect(updated_review.shop_food.food_id).to eq Food.first.id
      expect(updated_review.content).to eq @updated_content
      expect(updated_review.title).to eq @updated_title
      expect(updated_review.shop_food.shop_id).to eq updated_shop
      expect(updated_review.rate).to eq @updated_rate
      expect(updated_review.picture.file.filename).to eq @updated_picture
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_selector '.alert-success'
    end
  end

  describe '入力誤りがある時、更新されないこと' do
    before do
      log_in_as user
      visit edit_review_path(review.id)
    end
    it 'contentが誤り' do
      expect do
        fill_in '内容', with: ''
        click_button '修正する'
      end.to_not change { review.reload.inspect }
      expect(page).to have_selector '.alert-danger'
    end
    it 'titleが誤り' do
      expect do
        fill_in 'タイトル', with: ''
        click_button '修正する'
      end.to change(Review, :count).by(0)
    end
    it '画像がキャッシュされること' do
      attach_file 'pic_field', file_fixture(@updated_picture), make_visible: true
      fill_in 'タイトル', with: ''
      click_button '修正する'
      expect(page).to have_selector("img[src$='#{@updated_picture}']")
    end
  end

  describe '認証に問題があるため、ページが表示できないこと' do
    it '未ログインの場合' do
      visit edit_user_path(user.id)
      expect(page).to have_selector '.alert-danger'
      expect(current_path).to eq login_path
    end
    it 'ログインユーザ自身の編集ではない場合' do
      log_in_as user
      other_user = FactoryBot.create(:other_user)
      other_user_review = FactoryBot.create(:review, user: other_user)
      visit edit_review_path(other_user_review.id)
      expect(current_path).to eq review_path(other_user_review)
    end
  end
end
