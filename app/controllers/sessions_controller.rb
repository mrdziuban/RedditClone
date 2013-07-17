class SessionsController < ApplicationController
  before_filter :authenticate, except: [:new, :create]

  def create
    user = User.find_by_username(params[:session][:username])
    if user
      if user.authenticate(params[:session][:password])
        user.token = SecureRandom.urlsafe_base64
        user.save
        session[:token] = user.token
        redirect_to user_url(user)
      else
        flash[:notices] = "Incorrect password"
        render :new
      end
    else
      flash[:notices] = "Incorrect username"
      render :new
    end
  end

  def destroy
    @current_user = nil
    session[:token] = nil
    render :new
  end
end