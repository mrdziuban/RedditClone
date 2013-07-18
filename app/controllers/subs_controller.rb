class SubsController < ApplicationController
  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(params[:sub])
    @sub.moderator = @current_user.id
    @sub.links.each do |link|
      link.user_id = @current_user.id
    end
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:notices] = "Could not create sub"
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    @sorted_links = Kaminari.paginate_array(sort_links(@sub.links)).page(params[:page]).per(25)
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
    sub = Sub.find(params[:id])
    sub.destroy
    redirect_to subs_url
  end
end