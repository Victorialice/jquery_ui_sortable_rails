# encoding: utf-8
class HomeController < ApplicationController
  def index
    @news = New.public.limit(5)
  end

  def activity
    #
  end

  def presentation
    @campaign = Campaign.last
    @campaign_award_users = @campaign.campaign_award_users 
  end
end
