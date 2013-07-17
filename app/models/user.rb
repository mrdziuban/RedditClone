class User < ActiveRecord::Base
  attr_accessible :password_digest, :username, :password, :password_confirmation
  has_secure_password

  has_many :subs, foreign_key: :moderator
  has_many :links
  has_many :comments
  has_many :user_votes

  validates :username, presence: true, uniqueness: {scope: :username}
  validates :password, presence: :true, length: {minimum: 6}, on: :create
  validates :password, confirmation: true, allow_nil: true
  validates :password_confirmation, presence: true, length: {minimum: 6}, on: :create
end