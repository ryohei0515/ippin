# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateReviews', type: :system do
  include LoginSupport
  let(:user) { FactoryBot.create(:user) }
  before do
    @created_food = 'created_food'
    @created_category = 'created_ctgry'
    @created_content = 'created_content'
    @created_title = 'created_title'
    @created_restaurant = 'created_restaurant'
    @created_rate = 4.5
    @created_picture = 'food_pic_01.jpg'
  end

  it 'レビューを新規投稿できること' do
    log_in_as user
    visit new_review_path
    expect do
      fill_in 'Content', with: @created_content
      fill_in 'Food', with: @created_food
      fill_in 'Category', with: @created_category
      fill_in 'Title', with: @created_title
      fill_in 'Restaurant', with: @created_restaurant
      fill_in 'Rate', with: @created_rate
      attach_file 'Picture', file_fixture(@created_picture)
      click_button '新規投稿'
    end.to change(Review, :count).by(1)
    created_review = user.reviews.first
    aggregate_failures do
      expect(created_review.food.name).to eq @created_food
      expect(created_review.food.category).to eq @created_category
      expect(created_review.content).to eq @created_content
      expect(created_review.title).to eq @created_title
      expect(created_review.food.restaurant).to eq @created_restaurant
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
      fill_in 'Food', with: @created_food
      fill_in 'Category', with: @created_category
      fill_in 'Title', with: @created_title
      fill_in 'Restaurant', with: @created_restaurant
      fill_in 'Rate', with: @created_rate
      attach_file 'Picture', file_fixture(@created_picture)
    end
    after do
      expect do
        fill_in 'Content', with: @created_content
        fill_in 'Food', with: @created_food
        fill_in 'Category', with: @created_category
        fill_in 'Title', with: @created_title
        fill_in 'Restaurant', with: @created_restaurant
        fill_in 'Rate', with: @created_rate
        click_button '新規投稿'
      end.to change(Review, :count).by(1)
    end
    it 'foodが誤り' do
      expect do
        fill_in 'Food', with: ''
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
    end
    it 'categoryが誤り' do
      expect do
        fill_in 'Category', with: ''
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
    end
    it 'contentが誤り' do
      expect do
        fill_in 'Content', with: ''
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
    end
    it 'titleが誤り' do
      expect do
        fill_in 'Title', with: ''
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
    end
    it 'rateが誤り' do
      expect do
        fill_in 'Rate', with: ''
        click_button '新規投稿'
      end.to change(Review, :count).by(0)
    end
    it '画像がキャッシュされること' do
      fill_in 'Food', with: ''
      click_button '新規投稿'
      expect(page).to have_selector("img[src$='thumb_#{@created_picture}']")
    end
  end
end
