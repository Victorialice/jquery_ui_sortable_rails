# encoding: utf-8
class Admin::CampaignsController < Admin::AdminController
  def index
    @campaigns = Campaign.order('id desc')
  end

  def new
    #
  end

  def create
    @campaign = Campaign.new params[:campaign]
    if @campaign.save
      redirect_to admin_campaigns_path
    else
      render 'new'
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(params[:campaign])
      redirect_to admin_campaigns_path
    else
      redirect_to edit_admin_campaign_path(@campaign.id)
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    if @campaign.destroy
      render :json =>{msg: 'ok'}
    else
      render :json =>{msg: 'error'}
    end
  end

end