class SubsController < ApplicationController
  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    5.times do |i|
      if params[:sub][:links_attributes]["#{i}"][:title] == ""
        params[:sub][:links_attributes]["#{i}"][:sub_ids] = []
        params[:sub][:links_attributes]["#{i}"][:user_id] = ""
      end
    end
    @sub = Sub.new(params[:sub])
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:notices] = "Could not create sub"
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit
    @sub = Sub.find(params[:id])
    if @sub.user != @current_user
      redirect_to sub_url(@sub)
    end
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(params[:sub])
      redirect_to sub_url(@sub)
    else
      flash[:notices] = "Could not update sub"
      render :edit
    end
  end

  def destroy

  end
end