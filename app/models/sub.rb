class Sub < ActiveRecord::Base
  attr_accessible :moderator, :name, :links_attributes

  belongs_to :user, foreign_key: :moderator
  has_many :link_subs, dependent: :destroy
  has_many :links, through: :link_subs
  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true
end