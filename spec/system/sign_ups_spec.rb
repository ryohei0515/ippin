require 'rails_helper'

RSpec.describe "SignUps", type: :system do
  let(:user) { FactoryBot.build(:user) }

  it "ユーザ登録できること" do
    expect {
      visit signup_path
      fill_in "user_name", with: user.name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password_confirmation
      click_button "新規登録"
    }.to change(User, :count).by(1)

    created_user = User.find_by(name: user.name, email: user.email)
    aggregate_failures do
      expect(current_path).to eq user_path(created_user.id)
      expect(page).to have_selector 'a', text: 'ログアウト'
      expect(page).to_not have_selector 'a', text: 'ログイン'
    end
  end

  describe "入力誤りがある時、登録されないこと" do
    before {
      visit signup_path
      fill_in "user_name", with: user.name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password_confirmation
    }
    after {
      expect {
        fill_in "user_name", with: user.name
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
        fill_in "user_password_confirmation", with: user.password_confirmation
        click_button "新規登録"
      }.to change(User, :count).by(1)
    }

    it "user_nameが誤り" do
      expect {
        fill_in "user_name", with: ""
        click_button "新規登録"
      }.to_not change(User, :count)
    end

    it "user_emailが誤り" do
      expect {
        fill_in "user_email", with: ""
        click_button "新規登録"
      }.to_not change(User, :count)
    end

    it "user_passwordとuser_password_confirmationが不一致" do
      expect {
        fill_in "user_password", with: "user_password"
        fill_in "user_password_confirmation", with: "foobar"
        click_button "新規登録"
      }.to_not change(User, :count)
    end
  end


end
