# encoding: utf-8
#此模型为 兼容rails2项目
require 'digest/sha1'
require 'digest/sha2'
require 'securerandom'
class User < ActiveRecord::Base
  REST_AUTH_SITE_KEY = '2174f5a2df4bf6e58047f2d37c2e9f7734d0f251'
  attr_accessor :password

  attr_accessible :login, :password, :name, :nickname, :birthday, :address2,
                  :email_agreement, :gender, :job, :postcode, :detail_address,
                  :telphone, :login_confirmation, :password_confirmation, 
                  :origin, :uid

  validates :login, uniqueness: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, on: :create }
  validates :login, :password, presence: true, confirmation: true, on: :create
  #validates :crypted_password, :salt, presence: true

  has_many :campaign_records
  #has_many :campaigns, :through => :campaign_records, :source => :campaign

  before_save   :remove_html_tag
  before_create :encrypt_password
  before_create :make_email_token  #生成邮件激活码
  after_create  :send_active_email #发送激活邮件


  def self.password_digest(password, salt)
    digest = REST_AUTH_SITE_KEY
    10.times do
      digest = secure_digest(digest, salt, password, REST_AUTH_SITE_KEY)
    end
    digest
  end

  def self.secure_digest(*args)
    ::Digest::SHA1.hexdigest(args.flatten.join('--'))
  end

  def self.make_token
    secure_digest(Time.now, (1..10).map{ rand.to_s })
  end

  def self.secure_hash(string)
    ::Digest::SHA2.hexdigest(string.to_s)
  end

  def make_reset_pwd_token
    #self.update_column('reset_pwd_token', self.class.secure_hash("#{Time.now}_#{self.salt}"))
    User.exec_sql("update users set reset_pwd_token = '#{self.class.secure_hash("#{Time.now}_#{self.salt}")}', reset_pwd_state = 0 where id = #{self.id}")
  end

  def update_password(password)
    #self.update_column('crypted_password', self.encrypt(password))
    User.exec_sql("update users set crypted_password = '#{self.encrypt(password)}', reset_pwd_state = 1 where id = #{self.id}")
  end


  def encrypt(password)
    self.class.password_digest(password, self.salt)
  end

  def auth?(password)
    self.crypted_password == encrypt(password)
  end

  #当前用户是否参加了这次活动
  #参加了 返回true
  #没参加 返回false
  def is_join_campaign?(campaign_id)
    CampaignRecord.join_campaign(self.id, campaign_id).length > 0 ? true : false
  end


  #查找用户参与过的活动
  #为毛不用关联处理?
  def join_campaigns
    cr_ids = self.campaign_records.map(&:campaign_id)
    Campaign.where :id => cr_ids
  end

  def show_address
    Division.user_address(self.address2).first
  end


  def update_remember_token
    unless self.remember_token.present?
      self.update_column('remember_token', make_remember_token)
    end
  end

  def withdraw
    self.update_attribute(:state, "withdrawal")
  end


  private

  # before filter
  def encrypt_password
    return if self.password.blank?
    self.salt             = self.class.make_token if new_record?
    self.crypted_password = encrypt(password)
  end

  #生成email激活token
  def make_email_token
    self.activation_code = self.class.secure_hash("#{self.login}_#{self.salt}")
  end

  def send_active_email
    ::UserMailer.active_user(self).deliver if self.origin.blank? 
  end

  def make_remember_token
    ::SecureRandom.urlsafe_base64
  end


  def remove_html_tag
    [:name, :nickname, :job, :postcode, :detail_address, :telphone].each do |action|
      r = self.__send__(action)
      self.__send__("#{action}=".to_sym, ::Sanitize.clean(r)) if r.present?
    end
  end


end
