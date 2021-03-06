class LinksController < ApplicationController
  def index
    links = Link.all
    @sorted_links = Kaminari.paginate_array(sort_links(links)).page(params[:page]).per(25)
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    @link.comments.each do |comment|
      comment.user_id = @current_user.id
    end
    if @link.save
      redirect_to link_url(@link)
    else
      flash[:notices] = "Could not create link"
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
    link = Link.find(params[:id])
    link.destroy
    redirect_to links_url
  end

  def upvote
    @link = Link.find(params[:id])
    @user_vote = @current_user.user_votes.where(link_id: @link.id).first
    if @user_vote
      @user_vote.updown = true
      @user_vote.save
      redirect_to :back
    else
      @current_user.user_votes.create(link_id: @link.id, updown: true)
      redirect_to :back
    end
  end

  def downvote
    @link = Link.find(params[:id])
    @user_vote = @current_user.user_votes.where(link_id: @link.id).first
    if @user_vote
      @user_vote.updown = false
      @user_vote.save
      redirect_to :back
    else
      @current_user.user_votes.create(link_id: @link.id, updown: false)
      redirect_to :back
    end
  end
end