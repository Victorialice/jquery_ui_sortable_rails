# encoding: utf-8
class CampaignAwardUser < ActiveRecord::Base
  #attr_accessible
  belongs_to :campaign
end