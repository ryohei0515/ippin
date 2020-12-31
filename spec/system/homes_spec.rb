require 'rails_helper'

RSpec.describe "Homes", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:review_list) { FactoryBot.create_list(:review, 30, user: user) }

  it "ホーム画面のレビューが正しく表示されること" do
    review_list
    visit root_path
    aggregate_failures do
      expect(page).to have_content "#{review_list.count.to_s}件"
      expect(page).to have_selector '.pagination'
      for review in review_list[0..4] do
        expect(page).to have_content review.content
        expect(page).to have_content review.food.name
      end
    end
  end
end
