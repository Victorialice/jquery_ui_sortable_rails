# encoding: utf-8
#兼容rails2项目
class Division < ActiveRecord::Base
  #attr_accessible
  scope :user_address, lambda { |city_id| where('division2id = ? and division1name = "land_address2"', city_id) }
end