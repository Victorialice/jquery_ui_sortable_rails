# encoding: utf-8
class Campaign < ActiveRecord::Base
  attr_accessible :title, :content, :image, :begin_date, :over_date, :link
  validates :title, :content,:image, :begin_date, :over_date, presence: true

  mount_uploader :image, ::ImageUploader

  #取最新活动.每次只有一个 返回的是数组对象
  scope :latest_campaign, order('id desc').limit(1)

  #获取某个活动的获奖名单
  has_many :campaign_award_users

end