# encoding: utf-8
class Admin::TopimagesController < Admin::AdminController
  def index
    @topimages = Topimage.order('position asc')
  end

  def create
    ti = Topimage.new( 
                      image: params[:image], 
                      linkurl: params[:url].to_s,
                      target_blank: params[:target_blank]
                     )
    if ti.save
      render :text=>"<script language=\"javascript\" type=\"text/javascript\">window.top.window.ajax_image_cb(#{ {msg: 'ok'}.update(ti.to_m_hash).to_json })</script>"
    end
  end

  def destroy
    @topimage = Topimage.find params[:id]
    if @topimage.destroy
      render json: {msg: 'ok'}
    else
      render json: {msg: 'error'}
    end
  end

  def position
    params[:topimages].each_with_index do |ti, index|
      Topimage.update(ti.to_i, position: index + 1)
    end
    render :json =>{msg: 'ok'}
  end
end
