module SessionsHelper
  # 引数のユーザでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # 記憶トークンcookieに対応するユーザ or ログイン中のユーザを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザがログインしていればtrue、それ以外ならfalse
  def logged_in?
    !current_user.nil?
  end

  # 永続セッションを破棄
  def forget(user)
    user.forget
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
  end

  # 現在のユーザをログアウト
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # ユーザのセッションを永続化
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

end
