# encoding: utf-8
class Admin::SessionsController < Admin::AdminController
  skip_filter :admin_login_required, :only =>[:new, :create]

  def new
    #
  end

  def create
    admin = Admin.find_by_name params['login'].to_s
    return(redirect_to admin_login_path) unless admin

    if admin.auth?(params['password'])
      session[:admin] = admin.id
      redirect_to admin_root_path
    else
      redirect_to admin_login_path
    end
  end



end