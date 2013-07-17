class Sub < ActiveRecord::Base
  attr_accessible :moderator, :name#, :links_attributes

  belongs_to :user, foreign_key: :moderator
  # has_many :links
  # accepts_nested_attributes_for :links

  validates :name, presence: true, uniqueness: {scope: :name}
end