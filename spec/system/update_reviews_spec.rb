require 'rails_helper'

RSpec.describe "UpdateReviews", type: :system do
  include LoginSupport
  let(:user) { FactoryBot.create(:user) }
  let(:review) { FactoryBot.create(:review, user: user) }
  before do
    @updated_food = "updated_food"
    @updated_content = "updated_content"
  end

  it "ログインユーザ自身のレビューを更新できること" do
    log_in_as user
    visit edit_review_path(review.id)
    fill_in "Content", with: @updated_content
    fill_in "Food", with: @updated_food
    click_button "修正する"
    updated_review = Review.find(review.id)
    aggregate_failures do
      expect(updated_review.food).to eq @updated_food
      expect(updated_review.content).to eq @updated_content
      expect(current_path).to eq review_path(review.id)
    end
  end

  describe "入力誤りがある時、更新されないこと" do
    before {
      log_in_as user
      visit edit_review_path(review.id)
      fill_in "Content", with: @updated_content
      fill_in "Food", with: @updated_food
    }
    it "foodが誤り" do
      fill_in "Food", with: ""
      click_button "修正する"
      expect(Review.find(review.id).inspect).to eq review.inspect
    end
    it "contentが誤り" do
      fill_in "Content", with: ""
      click_button "修正する"
      expect(Review.find(review.id).inspect).to eq review.inspect
    end
  end

  describe "認証に問題があるため、ページが表示できないこと" do
    it "未ログインの場合" do
      visit edit_user_path(user.id)
      expect(page).to have_selector '.alert-danger'
      expect(current_path).to eq login_path
    end
    it "ログインユーザ自身の編集ではない場合" do
      log_in_as user
      other_user = FactoryBot.create(:other_user)
      other_user_review = FactoryBot.create(:review, user: other_user)
      visit edit_review_path(other_user_review.id)
      expect(current_path).to eq review_path(other_user_review)
    end
  end
end
