class UserVote < ActiveRecord::Base
  attr_accessible :link_id, :updown, :user_id

  belongs_to :link
  belongs_to :user
end