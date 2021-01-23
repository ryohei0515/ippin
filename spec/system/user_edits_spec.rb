require 'rails_helper'

RSpec.describe 'UserEdits', type: :system do
  include LoginSupport
  let(:user) { FactoryBot.create(:user) }
  before do
    @updated_name = 'updated_name'
    @updated_email = 'updated@example.com'
    @updated_password = 'updated_password'
  end

  describe 'ログインユーザ自身のユーザ情報を編集できること' do
    before do
      log_in_as user
      visit edit_user_path(user.id)
      fill_in 'user_name', with: @updated_name
      fill_in 'user_email', with: @updated_email
    end

    it '全情報の編集' do
      fill_in 'user_password', with: @updated_password
      fill_in 'user_password_confirmation', with: @updated_password
      click_button '登録情報更新'
      updated_user = User.find(user.id)
      aggregate_failures do
        expect(updated_user.name).to eq @updated_name
        expect(updated_user.email).to eq @updated_email
        expect(!!updated_user.authenticate(@updated_password)).to be_truthy
        expect(current_path).to eq edit_user_path(user.id)
      end
    end

    it 'パスワード以外の編集' do
      click_button '登録情報更新'
      updated_user = User.find(user.id)
      aggregate_failures do
        expect(updated_user.name).to eq @updated_name
        expect(updated_user.email).to eq @updated_email
        expect(current_path).to eq edit_user_path(user.id)
      end
    end
  end

  describe '入力誤りがある時、更新されないこと' do
    before do
      log_in_as user
      visit edit_user_path(user.id)
      fill_in 'user_name', with: @updated_name
      fill_in 'user_email', with: @updated_email
    end

    it 'nameが誤り' do
      expect do
        fill_in 'user_name', with: ''
        click_button '登録情報更新'
      end.to_not change { user.reload.inspect }
      expect(page).to have_selector '.alert-danger'
    end

    it 'emailが誤り' do
      expect do
        fill_in 'user_email', with: ''
        click_button '登録情報更新'
      end.to_not change { user.reload.inspect }
      expect(page).to have_selector '.alert-danger'
    end

    it 'passwordとpassword_confirmationが不一致' do
      expect do
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'foobar'
        click_button '登録情報更新'
      end.to_not change { user.reload.inspect }
      expect(page).to have_selector '.alert-danger'
    end
  end

  describe '認証に問題があるため、ページが表示できないこと' do
    it '未ログインの場合' do
      visit edit_user_path(user.id)
      expect(page).to have_selector '.alert-danger'
      expect(current_path).to eq login_path
    end
    it 'ログインユーザ自身の編集ではない場合' do
      log_in_as user
      other_user = FactoryBot.create(:other_user)
      visit edit_user_path(other_user.id)
      expect(current_path).to eq root_path
    end
  end
end
