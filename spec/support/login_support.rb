module LoginSupport
  def log_in_as(user, password: 'password', remember_me: '1')
    visit root_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    check "ログイン状態を記憶する" if remember_me == '1'
    click_button "ログイン"
  end

  # def in_browser(name)
  #   old_session = Capybara.session_name
  #   Capybara.session_name = name
  #   yield
  #   Capybara.session_name = old_session
  # end
end
