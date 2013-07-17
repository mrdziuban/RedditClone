class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to comment_url(@comment.parent_comment)
    else
      flash[:notices] = "Could not add comment"
      redirect_to comment_url(@comment.parent_comment)
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
    if @comment.user != @current_user
      redirect_to comment_url(@comment)
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to comment_url(@comment)
    else
      flash[:notices] = "Could not update comment"
      render :edit
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end
end