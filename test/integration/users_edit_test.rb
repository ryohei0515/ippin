require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '',
                                              email: 'foo@invalid',
                                              password: 'foo',
                                              password_confirmation: 'bar' } }

    assert_template 'users/edit'
  end

  test 'successful edit' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    follow_redirect!
    assert_nil session[:forwarding_url]
    assert_template 'users/edit'
    name = 'success'
    email = 'success@test.com'
    password = 'success'
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: password,
                                              password_confirmation: password } }
    assert_not flash.empty?
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    assert @user.authenticate(password)
    # パスワードを空で更新（変更なし）
    name = 'success_empty'
    email = 'success_empty@test.com'
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: '',
                                              password_confirmation: '' } }
    assert_not flash.empty?
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    assert @user.authenticate(password)
  end
end
