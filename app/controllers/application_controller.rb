class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  helper_method :what_is_users_vote?, :sort_links

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

  def sort_links(links)
    links_with_scores = {}
    links.each do |link|
      net_score = link.user_votes.where(updown: true).count - 
                  link.user_votes.where(updown: false).count
      links_with_scores[link] = net_score
    end
    sorted_hash = Hash[links_with_scores.sort_by{|k,v| v}.reverse]
    sorted_hash.keys
  end
end