class Link < ActiveRecord::Base
  attr_accessible :text, :title, :url, :user_id

  belongs_to :user

  validates :title, :url, presence: true
end
