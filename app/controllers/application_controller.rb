class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  def authenticate
    session[:token] ||= SecureRandom.urlsafe_base64
    @current_user = User.find_by_token(session[:token])
    unless @current_user
      redirect_to root_url
    end
  end
end
