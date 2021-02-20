# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper
  include HotpepperApi

  private

  # ログイン済みか確認
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'ログインしてください'
    redirect_to login_url
  end
end
