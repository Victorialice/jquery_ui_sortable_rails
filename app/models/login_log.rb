class LoginLog < ActiveRecord::Base
  belongs_to :user
  attr_accessible :ip, :user_id
end
