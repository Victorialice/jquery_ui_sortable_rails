# encoding: utf-8
require File.join(Rails.root, "app/uploader/image_uploader")
class Topimage < ActiveRecord::Base
  attr_accessible :image, :linkurl, :position, :target_blank
  validates :image, presence: true

  mount_uploader :image, ::ImageUploader

  scope :by_position, order('position asc')

  def to_m_hash
    {
        id:         self.id,
        imagepath:  self.image.url,
        url:        self.linkurl,
        created_at: self.created_at.my_format_time,
        updated_at: self.updated_at.my_format_time
    }
  end
end
