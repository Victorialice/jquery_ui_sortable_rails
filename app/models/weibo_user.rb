class WeiboUser < ActiveRecord::Base
  belongs_to :user
  attr_accessible :expires, :image, :image_small, :screen_name, :token, :uid, :user_id
  GENDER = {"m" => 1, "f" => 0}

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_by_origin_and_uid("weibo", auth_hash["uid"]) 
    if user.blank?
      user = User.new(
        origin: 'weibo',
        uid:    auth_hash['uid'],
        gender: GENDER[auth_hash['extra']['raw_info']['gender']],
        detail_address: auth_hash['extra']['raw_info']['location'],
        name: auth_hash['info']['name'],
        nickname: auth_hash['info']['nickname']
      )
      user.state = "active"
      user.save(:validate => false)
      create(
        user_id: user.id,
        uid: auth_hash['uid'],
        screen_name: auth_hash['info']['name'],
        image:  auth_hash['info']["image"].gsub("/50/","/180/"),
        image_small:  auth_hash['info']["image"],
        token:  auth_hash['credentials']['token'],
        expires:  auth_hash['credentials']['expires_at']
      )
      user
    end
    user
  end
end
