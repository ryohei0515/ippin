# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UpdateReviews', type: :system do
  include LoginSupport
  let(:user) { FactoryBot.create(:user) }
  let(:review) { FactoryBot.create(:review, user: user) }
  before do
    @updated_food = 'updated_food'
    @updated_category = 'updated_ctgry'
    @updated_content = 'updated_content'
    @updated_title = 'updatedd_title'
    @updated_restaurant = 'updatedd_restaurant'
    @updated_rate = 4.5
    @updated_picture = 'food_pic_02.jpg'
  end

  it 'ログインユーザ自身のレビューを更新できること' do
    log_in_as user
    visit edit_review_path(review.id)
    fill_in 'Content', with: @updated_content
    fill_in 'Food', with: @updated_food
    fill_in 'Category', with: @updated_category
    fill_in 'Title', with: @updated_title
    fill_in 'Restaurant', with: @updated_restaurant
    fill_in 'Rate', with: @updated_rate
    attach_file 'Picture', file_fixture(@updated_picture)
    click_button '修正する'
    updated_review = Review.find(review.id)
    aggregate_failures do
      expect(updated_review.food.name).to eq @updated_food
      expect(updated_review.food.category).to eq @updated_category
      expect(updated_review.content).to eq @updated_content
      expect(updated_review.title).to eq @updated_title
      expect(updated_review.food.restaurant).to eq @updated_restaurant
      expect(updated_review.rate).to eq @updated_rate
      expect(updated_review.picture.file.filename).to eq @updated_picture
      expect(current_path).to eq review_path(review.id)
    end
  end

  describe '入力誤りがある時、更新されないこと' do
    before do
      log_in_as user
      visit edit_review_path(review.id)
      fill_in 'Content', with: @updated_content
      fill_in 'Food', with: @updated_food
      fill_in 'Category', with: @updated_category
      fill_in 'Title', with: @updated_title
      fill_in 'Restaurant', with: @updated_restaurant
      fill_in 'Rate', with: @updated_rate
    end
    it 'foodが誤り' do
      expect do
        fill_in 'Food', with: ''
        click_button '修正する'
      end.to_not change { review.reload.inspect }
      expect(page).to have_selector '.alert-danger'
    end
    it 'categoryが誤り' do
      expect do
        fill_in 'Category', with: ''
        click_button '修正する'
      end.to_not change { review.reload.inspect }
      expect(page).to have_selector '.alert-danger'
    end
    it 'contentが誤り' do
      expect do
        fill_in 'Content', with: ''
        click_button '修正する'
      end.to_not change { review.reload.inspect }
      expect(page).to have_selector '.alert-danger'
    end
    it 'titleが誤り' do
      expect do
        fill_in 'Title', with: ''
        click_button '修正する'
      end.to change(Review, :count).by(0)
    end
    it 'rateが誤り' do
      expect do
        fill_in 'Rate', with: ''
        click_button '修正する'
      end.to change(Review, :count).by(0)
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
