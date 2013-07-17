class UsersController < ApplicationController
  before_filter :authenticate, except: [:new, :create]

  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.token = SecureRandom.urlsafe_base64
      @user.save
      session[:token] = @user.token
      redirect_to user_url(@user)
    else
      flash[:notices] = "Could not create user"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit

  end

  def update

  end

  def destroy

  end
end