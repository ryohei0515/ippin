# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'likeReviews', type: :system, js: true do
  include LoginSupport
  include AjaxHelper

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:review) { FactoryBot.create(:review, user: other_user) }
  let(:own_review) { FactoryBot.create(:review, user: user) }

  before do
    @like_button = '参考になった'
    @unlike_button = '取消'
    log_in_as user
    visit shop_food_path(review.shop_food_id)
  end

  it 'likeしていないreviewに対し、like用のボタンを押すことで、登録されること' do
    expect do
      click_button @like_button
      wait_for_loaded_until_css_disappeared("input[value='#{@like_button}']")
    end.to change { user.like_reviews.count }.by(1)
    expect(page).to_not have_button @like_button
    expect(page).to have_button @unlike_button
  end

  it 'like済のreviewに対し、like用のボタンを押すことで、解除されること' do
    click_button @like_button
    wait_for_loaded_until_css_disappeared("input[value='#{@like_button}']")

    expect do
      click_button @unlike_button
      wait_for_loaded_until_css_disappeared("input[value='#{@unlike_button}']")
    end.to change { user.like_reviews.count }.by(-1)
    expect(page).to_not have_button @unlike_button
    expect(page).to have_button @like_button
  end

  it 'like用のボタンをクリックするたびに、画面のliked_usersの人数が更新されること' do
    expect(page).to have_content "#{review.liked_users.count}人"

    FactoryBot.create_list(:like, Random.rand(2..5), review: review)
    click_button @like_button
    wait_for_loaded_until_css_disappeared("input[value='#{@like_button}']")
    expect(page).to have_content "#{review.liked_users.count}人"

    FactoryBot.create_list(:like, Random.rand(2..5), review: review)
    click_button @unlike_button
    wait_for_loaded_until_css_disappeared("input[value='#{@unlike_button}']")
    expect(page).to have_content "#{review.liked_users.count}人"
  end

  it 'ユーザ自身のreviewに対し、like用のボタンが表示されないこと' do
    visit shop_food_path(own_review.shop_food_id)

    expect(page).to_not have_button @like_button
    expect(page).to_not have_button @unlike_button
  end
end
