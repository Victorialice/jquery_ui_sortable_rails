class New < ActiveRecord::Base
  attr_accessible :category, :date, :is_public, :link, :message, :title

  scope :public, where('is_public is true').order('date DESC')

end
