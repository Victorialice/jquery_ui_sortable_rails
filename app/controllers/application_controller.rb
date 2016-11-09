class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
  after_filter :reset_last_captcha_code!

  protect_from_forgery
  before_filter :check_cookie

  def check_login
    unless logined?
      redirect_to root_path
    end
  end

  def logined?
    !!session[:user_id]
  end
  helper_method :logined?

  def current_user
    @current_user ||= User.find(session[:user_id] || session[:sns_user_id])
  end
  helper_method :current_user

protected

  def check_cookie
    if cookies[:remember_me].present?
      unless logined?
        if cookies.signed[:remember_me].present? && cookies[:email].present?
          user = User.find_by_login(cookies[:email].to_s)
          if user && user.remember_token == cookies.signed[:remember_me]
            session[:user_id] = user.id
          end
        end
      end
    end
  end


end
