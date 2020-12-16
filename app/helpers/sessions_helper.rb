module SessionsHelper
  # 引数のユーザでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # ログイン中のユーザを返す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # ユーザがログインしていればtrue、それ以外ならfalse
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザをログアウト
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
