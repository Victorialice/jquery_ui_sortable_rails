class XiaoneiUser < ActiveRecord::Base
  belongs_to :user
  attr_accessible :expires, :image, :image_small, :screen_name, :token, :uid, :user_id


  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_by_origin_and_uid("xiaonei", auth_hash["uid"]) 
    if user.blank?
      user = User.new(
        origin: 'xiaonei',
        uid:    auth_hash['uid'],
        gender: auth_hash['extra']['raw_info']['sex'],
        name: auth_hash['info']['name'],
        nickname: auth_hash['info']['name']
      )
      user.state = "active"
      user.save(:validate => false)
      create(
        user_id: user.id,
        uid: auth_hash['uid'],
        screen_name: auth_hash['info']['name'],
        image:  auth_hash['info']['headurl'],
        image_small:  auth_hash['info']['tinyurl'],
        token:  auth_hash['credentials']['token'],
        expires:  auth_hash['credentials']['expires_at']
      )
      user
    end
    user
  end
end
