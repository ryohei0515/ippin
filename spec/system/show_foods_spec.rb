require 'rails_helper'

RSpec.describe "ShowFoods", type: :system do
  include ActionView::Helpers::DateHelper
  let(:review_list) { FactoryBot.create_list(:review, 30, food: food) }
  let(:food) { FactoryBot.create(:food) }

  it "正しくfoodとそれに紐づくReviewを表示できること" do
    review_list
    visit food_path(food.id)
    aggregate_failures do
      expect(page).to have_content food.name
      expect(page).to have_content food.restaurant
      expect(page).to have_content food.category
      expect(page).to have_content food.rate
      expect(page).to have_content "#{food.reviews.count.to_s}件"
      expect(page).to have_selector '.pagination'
      for review in food.reviews.order(rate: :desc)[0..4] do
        expect(page).to have_content review.title
        expect(page).to have_content review.content
        expect(page).to have_content review.rate
        expect(page).to have_content review.user.name
        expect(page).to have_content time_ago_in_words(review.updated_at)
      end
    end
  end
end
