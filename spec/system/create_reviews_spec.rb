require 'rails_helper'

RSpec.describe "CreateReviews", type: :system do
  include LoginSupport
  let(:user) { FactoryBot.create(:user) }
  before do
    @created_food = "created_food"
    @created_content = "created_content"
  end

  it "レビューを新規投稿できること" do
    log_in_as user
    visit new_review_path
    expect {
      fill_in "Content", with: @created_content
      fill_in "Food", with: @created_food
      click_button "新規投稿"
    }.to change(Review, :count).by(1)
    created_review = user.reviews.first
    aggregate_failures do
      expect(created_review.food).to eq @created_food
      expect(created_review.content).to eq @created_content
      expect(current_path).to eq review_path(created_review.id)
    end
  end

  describe "入力誤りがある時、投稿されないこと" do
    before {
      log_in_as user
      visit new_review_path
      fill_in "Content", with: @created_content
      fill_in "Food", with: @created_food
    }
    after {
      expect {
        fill_in "Content", with: @created_content
        fill_in "Food", with: @created_food
        click_button "新規投稿"
      }.to change(Review, :count).by(1)
    }
    it "foodが誤り" do
      expect {
        fill_in "Food", with: ""
        click_button "新規投稿"
      }.to change(Review, :count).by(0)
    end
    it "contentが誤り" do
      expect {
        fill_in "Content", with: ""
        click_button "新規投稿"
      }.to change(Review, :count).by(0)
    end
  end
end
