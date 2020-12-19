class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper

  private

    #ログイン済みか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

end
