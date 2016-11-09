#encoding: utf-8
class SnsSessionsController < ApplicationController
  require 'rest_client'
  before_filter :login_required, :only => [:destroy]

  def create
    case params[:provider]
    when "weibo"
      @user = WeiboUser.find_or_create_from_auth_hash(auth_hash)
    when "xiaonei"
      @user = XiaoneiUser.find_or_create_from_auth_hash(auth_hash)
    when "qq_connect"
      @user = QqUser.find_or_create_from_auth_hash(auth_hash)
    end
    session[:user_id] = @user.id
    cookies.signed[:logged_flag] = true
    #redirect_to "/", :notice => "谢谢登陆"
    if @user.login.blank?
      redirect_to mypage_path(@user.id, :from_auth =>true)
    else
      redirect_to mypage_path(@user.id)
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:logged_flag)
    redirect_to root_url, :notice => "退出成功"
  end

  def failure
    render :text => "授权失败"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end


end
