class Sub < ActiveRecord::Base
  attr_accessible :moderator, :name, :links_attributes

  belongs_to :user, foreign_key: :moderator
  # As is, I'm getting an "undefined attribute sub_id" error when creating a sub
  has_many :links, # through: :link_subs
  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :name, presence: true, uniqueness: {scope: :name}
end