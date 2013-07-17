class SubsController < ApplicationController
  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(params[:sub])
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:notices] = "Name already taken"
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit

  end

  def update

  end

  def destroy

  end
end