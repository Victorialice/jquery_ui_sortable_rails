# encoding: utf-8
class Admin::AdminController < ActionController::Base
  #helper :all
  protect_from_forgery
  layout 'admin'
  before_filter :admin_login_required

  def current_admin
    #
  end

  def is_login?
    !!session[:admin]
  end
  helper_method :is_login?


  private
  def admin_login_required
    redirect_to(admin_login_path) unless is_login?
  end
end