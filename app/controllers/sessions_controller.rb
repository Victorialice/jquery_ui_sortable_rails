# encoding: utf-8
class SessionsController < ApplicationController
  before_filter :check_login, :only =>[:destroy, :widget_index]
  skip_before_filter :verify_authenticity_token, :only =>[:create, :destroy]

  def create
    jump_url = request.env['HTTP_REFERER']
    user     = User.where('login = ? and state = "active"', params[:name].to_s)[0]
    if user && user.auth?(params[:password])
      session[:user_id] = user.id
      cookies.signed[:logged_flag] = true

      if params[:rememberme].present? && params[:rememberme].to_i == 1
        user.update_remember_token
        cookies.signed[:remember_me] = {
            value:   user.remember_token,
            expires: 3.day.from_now.utc
        }
        cookies[:email] = {
            value:   user.login,
            expires: 3.day.from_now.utc
        }
      end
      if request.xhr?
        render :json =>{msg: 'ok', userid: user.id}
      else
        redirect_to(jump_url.present? ? jump_url : mypage_path(user.id))
      end
    else
      if request.xhr?
        render :json =>{msg: 'error'}
      else
        redirect_to(jump_url.present? ? jump_url : root_path)
      end
    end
  end

  def forgot_pwd
    user = User.where('login = ?', params[:email].to_s)[0]
    puts user.state
    puts "************"
    if user.state == "active"
      user.make_reset_pwd_token
      user.reload
      ::UserMailer.forgot_password(user).deliver
      render :json =>{msg: 'ok'}
      return
    end
    if user.state == "withdrawal"
      puts "got here"
      render :json =>{msg: 'KO'}
      return
    end
    if user.blank?
      render :json =>{msg: 'error'}
      return
    end
  end

  def reset_password
    user = User.where('login = ? and state = "active"', params[:email].to_s)[0]
    if user && user.reset_pwd_token == params[:token].to_s && !user.reset_pwd_state?
      #
    else
      return redirect_to(root_path)
    end
  end

  def reset_pwd_sure
    if !params[:password].present? || params[:password] != params[:password_confirmation]
      render :json =>{msg: 'error'}
      return
    end

    user = User.where('login = ? and state = "active"', params[:email].to_s)[0]
    if user && user.reset_pwd_token == params[:token].to_s && !user.reset_pwd_state?
      user.update_password(params[:password].to_s)
      render :json =>{msg: 'ok'}
    else
      render :json =>{msg: 'error'}
    end
  end


  def destroy
    reset_session
    cookies.delete(:logged_flag)
    cookies.delete(:remember_me)
    cookies.delete(:email)
    render :json =>{msg: 'ok'}
  end

  def active_user
    user = User.where('login = ? and state = "passive"', params[:email].to_s)[0]
    if user && user.activation_code == params[:token].to_s
      User.exec_sql("update users set state = 'active', activated_at = '#{Time.now}' where id = #{user.id}")
      session[:user_id] = user.id
      redirect_to mypage_path(user.id)
    else
      redirect_to(root_path)
    end
  end


  def widget
    #
  end

  def widget_login
    unless captcha_valid?(params[:captcha])
      redirect_to '/widget/login'
      return
    end
    user = User.where('login = ? and state = "active"', params[:name].to_s)[0]
    if user && user.auth?(params[:password])
      session[:user_id] = user.id

      if params[:rememberme].present? && params[:rememberme].to_i == 1
        user.update_remember_token
        cookies.signed[:remember_me] = {
            value:   user.remember_token,
            expires: 3.day.from_now.utc
        }
        cookies[:email] = {
            value:   user.login,
            expires: 3.day.from_now.utc
        }
      end
      redirect_to '/widget/index'
    else
      redirect_to '/widget/login'
    end
  end

  def widget_index
    #
  end

end
