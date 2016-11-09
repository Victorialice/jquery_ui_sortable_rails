#encoding=utf-8
class QqUser < ActiveRecord::Base
  belongs_to :user
  attr_accessible :expires, :figureurl, :image, :name, :nickname, :references, :token, :uid, :user_id
  GENDER = {"男" => 1, "女" => 0}

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_by_origin_and_uid("qq_connect", auth_hash["uid"]) 
    if user.blank?
      user = User.new(
        origin: 'qq_connect',
        uid:    auth_hash['uid'],
        gender: GENDER[auth_hash['extra']['raw_info']['gender']],
        name: auth_hash['info']['name'],
        nickname: auth_hash['info']['nickname']
      )
      user.state = "active"
      user.save(:validate => false)
      create(
        user_id: user.id,
        uid: auth_hash['uid'],
        figureurl: auth_hash['extra']['raw_info']['figureurl'],
        name: auth_hash['info']['name'],
        nickname: auth_hash['info']['nickname'],
        image:  auth_hash['info']['image'],
        token:  auth_hash['credentials']['token'],
        expires:  auth_hash['credentials']['expires_at']
      )
      user
    end
    user
  end
end
