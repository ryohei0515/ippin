# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DestroyReviews', type: :system, js: true do
  include LoginSupport
  include AjaxHelper

  let(:shop_food) { FactoryBot.create(:shop_food, rate: 3) }
  let(:user) { FactoryBot.create(:user) }
  let(:review) { FactoryBot.create(:review, user: user, shop_food: shop_food) } # 削除対象のレビュー
  let(:other_review) { FactoryBot.create(:review, user: user, shop_food: shop_food, rate: 5) } # ShopFoodが削除されないためのレビュー

  it 'ログインユーザ自身の投稿を削除できること' do
    log_in_as user
    visit review_path(review.id)
    other_review
    expect(ShopFood.count).to eq 1
    expect do
      click_link '削除'
      accept_confirm
      wait_for_loaded_until_css_exists('.alert-success')
    end.to change { Review.count }.by(-1)
    expect(ShopFood.count).to eq 1 # ShopFoodが削除されていないこと
    expect(shop_food.reload.rate).to eq other_review.rate # ShopFoodのrateが再計算されていること
    expect(current_path).to eq user_path(user.id)
    expect(page).to have_selector '.alert-success'
  end

  it 'レビュー削除により当該のShopFoodのレビュー件数が0件となった場合、ShopFoodも削除されること' do
    log_in_as user
    visit review_path(review.id)
    expect do
      click_link '削除'
      accept_confirm
      wait_for_loaded_until_css_exists('.alert-success')
    end.to change { ShopFood.count }.from(1).to(0)
    expect(current_path).to eq user_path(user.id)
    expect(page).to have_selector '.alert-success'
  end

  describe '認証に問題があるため削除リンクが表示されないこと' do
    it '未ログインの場合' do
      visit review_path(review.id)
      expect(page).to have_no_link '削除'
    end
    it 'ログインユーザ自身の投稿ではない場合' do
      log_in_as user
      other_user = FactoryBot.create(:other_user)
      other_user_review = FactoryBot.create(:review, user: other_user)
      visit review_path(other_user_review.id)
      expect(page).to have_no_link '削除'
    end
  end
end
