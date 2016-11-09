# encoding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "glico@kembo88.com"
  URL = 'http://www.glico.com.cn'

  def forgot_password(user)
    @user = user
    mail(to: user.login, subject: '重新设置密码')
  end

  def active_user(user)
    @user = user
    mail(to: user.login, subject: '激活帐号')
  end

end
