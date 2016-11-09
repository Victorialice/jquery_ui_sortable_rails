# encoding: utf-8
class Admin::NewsController < Admin::AdminController
  def index
    @news = New.order('id desc').page params[:page]  
  end

  def new
    #
  end

  def create
    @new = New.new params[:new]
    if @new.save
      redirect_to admin_news_index_path
    else
      render 'new'
    end
  end

  def edit
    @new = New.find(params[:id])
  end

  def update
    @new = New.find(params[:id])
    params[:new][:is_public] = (params[:new][:is_public].present? ? 1 : 0)
    if @new.update_attributes(params[:new])
      redirect_to admin_news_index_path
    else
      redirect_to edit_admin_news_path(@new.id)
    end
  end

  def destroy
    @new = New.find(params[:id])
    if @new.destroy
      render :json =>{msg: 'ok'}
    else
      render :json =>{msg: 'error'}
    end
  end

end
