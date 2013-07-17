class Link < ActiveRecord::Base
  attr_accessible :text, :title, :url, :user_id, :sub_ids, :comments_attributes
  paginates_per 25

  belongs_to :user
  has_many :link_subs
  has_many :subs, through: :link_subs
  has_many :comments
  has_many :user_votes

  accepts_nested_attributes_for :comments, reject_if: :all_blank

  validates :title, :url, presence: true

  def comments_by_parent
    link_comments = self.comments
    comments_hash = {}
    link_comments.each do |comment|
      comments_hash[comment.parent_comment_id] ||= []
      comments_hash[comment.parent_comment_id] << comment
    end
    comments_hash
  end
end
