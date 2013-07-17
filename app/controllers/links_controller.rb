class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to link_url(@link)
    else
      flash[:notices] = "Could not create link"
      p @link.errors.full_messages
      p "PARAMS"
      p params
      render :new
    end
  end

  def show
    @link = Link.find(params[:id])
  end

  def edit
    @link = Link.find(params[:id])
    if @current_user != @link.user
      redirect_to link_url(@link)
    end
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to link_url(@link)
    else
      flash[:notices] = "Could not update link"
      render :edit
    end
  end

  def destroy

  end
end