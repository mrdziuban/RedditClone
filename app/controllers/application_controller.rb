class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  helper_method :what_is_users_vote?

  def authenticate
    session[:token] ||= SecureRandom.urlsafe_base64
    @current_user = User.find_by_token(session[:token])
    unless @current_user
      redirect_to root_url
    end
  end

  def what_is_users_vote?(link)
    @user_vote = @current_user.user_votes.where(link_id: link.id).first
    if @user_vote
      @user_vote.updown
    else
      nil
    end
  end
end