# encoding: utf-8
class CampaignRecord < ActiveRecord::Base
  attr_accessible :user_id, :campaign_id, :postcode, :address2, :telphone, :name

  #某个用户参加的活动
  scope :join_campaign, lambda { |user_id, campaign_id|
    where('user_id = ? and campaign_id = ?', user_id.to_i, campaign_id.to_i)
    .order('id desc').limit(1)
  }
end


#address2表示用户参与活动用另外的地址。
#如果address2为空 表示用户使用注册资料里的地址
