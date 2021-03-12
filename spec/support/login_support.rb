# frozen_string_literal: true

module LoginSupport
  def log_in_as(user, remember_me: '1')
    visit root_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    check 'ログイン状態を記憶する' if remember_me == '1'
    click_button 'ログイン'
  end
end
