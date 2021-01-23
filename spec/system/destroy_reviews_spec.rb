require 'rails_helper'

RSpec.describe 'DestroyReviews', type: :system, js: true do
  include LoginSupport
  let(:user) { FactoryBot.create(:user) }
  let(:review) { FactoryBot.create(:review, user: user) }

  it 'ログインユーザ自身の投稿を削除できること' do
    log_in_as user
    visit review_path(review.id)
    expect do
      click_link '削除'
      accept_confirm
      find '.alert-success', text: 'レビューを削除しました'
    end.to change { Review.count }.by(-1)
    expect(current_path).to eq user_path(user.id)
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
