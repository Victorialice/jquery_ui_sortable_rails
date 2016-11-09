# encoding: utf-8
require 'csv'
class Admin::AwardController < Admin::AdminController
  def add_user
    @cam = Campaign.latest_campaign.last
  end

  def add_award_csv_user
    #是否要检测上传文件的格式?

    #检测是否已经传过
    if CampaignAwardUser.where('campaign_id = ?', params[:campaign_id].to_i).length > 0
      render :text=>"<script language=\"javascript\" type=\"text/javascript\">window.top.window.campagin_csv(1)</script>"
      return
    end
    campaign = Campaign.find(params[:campaign_id].to_i)

    #检测该活动是否过期
    if campaign.over_date >= Time.now.to_date
      render :text=>"<script language=\"javascript\" type=\"text/javascript\">window.top.window.campagin_csv(2)</script>"
      return
    end

    temp_csv_path = params[:csv_file].tempfile.path
    ::CSV.foreach(temp_csv_path) do |row|
      begin
        cau = CampaignAwardUser.new
        cau.campaign_id   = campaign.id
        cau.username      = row[0]
        cau.telphone      = row[1]
        temp_tel          = row[1].clone
        temp_tel[3, 4]    = 'xxxx'
        cau.mark_telphone = temp_tel
        cau.save
      rescue
        next
      end
    end
    render :text=>"<script language=\"javascript\" type=\"text/javascript\">window.top.window.campagin_csv()</script>"
  end
end
