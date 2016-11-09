# encoding: utf-8
class UsersController < ApplicationController
  before_filter :check_login, :except => [:add, :add_success, :check_email]

  def show
    user = User.find(params[:id].to_i)
    if user.id != current_user.id
      redirect_to mypage_path(current_user.id)
    end
    #取最新活动.每次只有一个
    @campaign = Campaign.latest_campaign[0]
  end

  def me
    user = User.find(current_user.id)
    #取最新活动.每次只有一个
    @campaign = Campaign.latest_campaign[0]
    render :show
  end

  def add
    @user = User.new
  end

  def add_success
    @user = User.new params[:user]
    path = "http://glico-cp.com.cn/users/create_by_api"
    uri = URI.parse("#{path}") 
    if @user.save
      begin 
       res = Net::HTTP.post_form(
         uri, 'login' => @user.login, 'name' => @user.name,
           'nickname' => @user.nickname, 'birthday' => @user.birthday,
           'address1' => @user.address1,  'address2' => @user.address2,
           'like_snack' => @user.like_snack, 'email_agreement' => @user.email_agreement,
           'is_admin' => @user.is_admin, 'deleted_at' => @user.deleted_at,
           'crypted_password' => @user.crypted_password, 'salt' => @user.salt,
           'created_at' => @user.created_at, 'updated_at' => @user.updated_at,
           'remember_token' => @user.remember_token, 'remember_token_expires_at' => @user.remember_token_expires_at,
           'activation_code' => @user.activation_code, 'activated_at' => @user.activated_at
       )
      rescue
      end
    else
      render 'add'
    end
  end

  def edit
    if current_user.id != params[:id].to_i
      redirect_to root_path
      return
    end
  end

  def update
    if current_user.id != params[:id].to_i
      redirect_to root_path
    else
      params[:user].delete(:login)
      params[:user].delete(:password)
      current_user.update_attributes params[:user]
      redirect_to mypage_path(current_user.id)
    end
  end

  def join_campaign
    campaign = Campaign.find(params[:campaign_id].to_i) rescue nil || Campaign.latest_campaign[0]

    if campaign.nil?
      render :json =>{msg: 'has no campagin', success: 'nocampagin'}
      return
    end

    if current_user.is_join_campaign?(campaign.id)
      render :json =>{msg: 'had join', success: 'no'}
    else
      if CampaignRecord.create user_id:     current_user.id,
                               campaign_id: campaign.id,
                               name:        current_user.name,
                               postcode:    params[:postcode].to_s,
                               address2:    params[:address2].to_s,
                               telphone:    params[:telphone].to_s

        render :json =>{success: 'yes', user_id: current_user.id}
      else
        render :json =>{success: 'no', msg: 'something error'}
      end
    end

  end

  def join_campaign1
    campaign = Campaign.find(params[:campaign_id].to_i) rescue nil || Campaign.latest_campaign[0]
    if campaign.nil?
      render :json =>{msg: 'has no campagin', success: 'nocampagin'}
      return
    end

    if current_user.is_join_campaign?(campaign.id)
      render :json =>{msg: 'had join', success: 'no'}
    else
      if ActiveRecord::Base.transaction do 
        CampaignRecord.create(
          user_id:     current_user.id,
          campaign_id: campaign.id,
          name:        params[:name].to_s,
          postcode:    params[:postcode].to_s,
          address2:    params[:detail_address].to_s,
          telphone:    params[:telphone].to_s
        )
        current_user.update_attributes( 
                                       name:       params[:name].to_s,
                                       postcode:       params[:postcode].to_s,
                                       detail_address: params[:detail_address].to_s,
                                       telphone:       params[:telphone].to_s
                                      )
      end

      render :json =>{success: 'yes', user_id: current_user.id}
      else
        render :json =>{success: 'no', msg: 'something error'}
      end
    end
  end

  def check_email
    user = User.find_by_login(params[:email])

    if user.nil?
      render :json =>{msg: '', success: 'OK'}
      return
    end
    
    if user.present? && user.state == "active"
      render :json =>{msg: '此邮件地址已被注册并激活', success: 'NG'}
      return
    end

    if user.present? && (user.state == "pending" || user.state == "passive")
      render :json =>{msg: '此邮件地址已被注册, 但倘未激活', success: 'NG'}
      return
    end

    if user.present? && user.state == "withdrawal"
      render :json =>{msg: '该邮箱帐号处于退会状态', success: 'NG'}
      return
    end

  end

  def auth_update_email
    user = User.find_by_login(params[:auth_email].to_s)
    if user
      render :json =>{success: 0, msg: '已经注册'}
    else
      current_user.update_column('login', params[:auth_email].to_s)
      render :json =>{success: 1, msg: '更新成功'}
    end
  end

  def withdraw
    if current_user.withdraw
      reset_session
      cookies.delete(:logged_flag)
      cookies.delete(:remember_me)
      cookies.delete(:email)
      render :json =>{success: "OK", msg: '您已成功退会,并将跳转到首页。若想恢复该帐号，请与客服联系!'}
    else
      render :json =>{success: "KO", msg: '出问题啦，未能成功退会'}
    end
  end

end
