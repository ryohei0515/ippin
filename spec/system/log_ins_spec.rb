# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Log in', type: :system do
  include LoginSupport
  let(:user) { FactoryBot.create(:user) }

  it 'ログインできること' do
    visit root_path
    click_link 'ログイン'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'ログイン'

    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(page).to have_selector 'a', text: 'ログアウト'
      expect(page).to_not have_selector 'a', text: 'ログイン'
    end
  end

  it 'パスワード不一致の場合、ログインできないこと' do
    visit root_path
    click_link 'ログイン'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'invalid'
    click_button 'ログイン'

    aggregate_failures do
      expect(current_path).to eq login_path
      expect(page).to have_selector '.alert-danger'
    end
  end

  it 'ログアウトできること' do
    log_in_as user

    click_link 'ログアウト'
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(page).to have_selector 'a', text: 'ログイン'
      expect(page).to_not have_selector 'a', text: 'ログアウト'
    end
  end

  it 'ログイン状態の記憶にチェックを入れている場合、ブラウザ再起動後ログイン状態であること' do
    visit root_path
    click_link 'ログイン'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    check 'ログイン状態を記憶する'
    click_button 'ログイン'

    # cookieを一時退避
    remember_token_value = Capybara.current_session.driver.request.cookies
                            .[]('remember_token')
    user_id_value = Capybara.current_session.driver.request.cookies
                            .[]('user_id')
    # セッション削除
    Capybara.reset_sessions!

    # 退避したcookieを再設定し、再アクセス
    page.driver.browser.set_cookie("remember_token=#{remember_token_value}")
    page.driver.browser.set_cookie("user_id=#{user_id_value}")
    visit root_path
    aggregate_failures do
      expect(page).to have_selector 'a', text: 'ログアウト'
      expect(page).to_not have_selector 'a', text: 'ログイン'
    end
  end

  it 'ログイン状態の記憶にチェックを入れていない場合、ブラウザ再起動後ログイン状態でないこと' do
    visit root_path
    click_link 'ログイン'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'ログイン'

    # cookieを一時退避（remember_tokenは空の想定）
    remember_token_value = Capybara.current_session.driver.request.cookies
                            .[]('remember_token')
    user_id_value = Capybara.current_session.driver.request.cookies
                            .[]('user_id')
    # セッション削除
    Capybara.reset_sessions!

    # 退避したcookieを再設定し、再アクセス
    page.driver.browser.set_cookie("remember_token=#{remember_token_value}")
    page.driver.browser.set_cookie("user_id=#{user_id_value}")
    visit root_path
    aggregate_failures do
      expect(page).to have_selector 'a', text: 'ログイン'
      expect(page).to_not have_selector 'a', text: 'ログアウト'
    end
  end

  it 'ゲストログイン機能よりログインできること' do
    FactoryBot.create(:sample_user)
    visit root_path
    click_link 'ログイン'
    click_button 'ゲストログイン'

    aggregate_failures do
      expect(current_path).to eq user_path(Settings.sample_user.id)
      expect(page).to have_selector 'a', text: 'ログアウト'
      expect(page).to_not have_selector 'a', text: 'ログイン'
    end
  end
end
