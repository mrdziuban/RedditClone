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
  end

  def update

  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end
end