# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'likeReviews', type: :system, js: true do
  include LoginSupport
  include AjaxHelper

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:review) { FactoryBot.create(:review, user: other_user) }
  let(:own_review) { FactoryBot.create(:review, user: user) }

  it 'likeしていないreviewに対し、like用のボタンを押すことで、登録されること' do
    log_in_as user
    @user = user
    visit shop_food_path(review.shop_food_id)

    expect do
      click_button '参考になった'
      wait_for_loaded_until_css_disappeared('input[value="参考になった"]')
    end.to change { user.like_reviews.count }.by(1)
    expect(page).to_not have_button '参考になった'
    expect(page).to have_button '取消'
  end

  it 'like済のreviewに対し、like用のボタンを押すことで、解除されること' do
    log_in_as user
    visit shop_food_path(review.shop_food_id)
    click_button '参考になった'
    wait_for_loaded_until_css_disappeared('input[value="参考になった"]')

    expect do
      click_button '取消'
      wait_for_loaded_until_css_disappeared('input[value="取消"]')
    end.to change { user.like_reviews.count }.by(-1)
    expect(page).to_not have_button '取消'
    expect(page).to have_button '参考になった'
  end

  it 'ユーザ自身のreviewに対し、like用のボタンが表示されないこと' do
    log_in_as user
    visit shop_food_path(own_review.shop_food_id)

    expect(page).to_not have_button '参考になった'
    expect(page).to_not have_button '取消'
  end
end
