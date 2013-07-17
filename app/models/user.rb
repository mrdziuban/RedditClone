class User < ActiveRecord::Base
  attr_accessible :password_digest, :username, :password, :password_confirmation
  has_secure_password

  has_many :subs, foreign_key: :moderator, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_votes#, dependent: :destroy

  validates :username, presence: true, uniqueness: {scope: :username}
  validates :password, presence: :true, length: {minimum: 6}, on: :create
  validates :password, confirmation: true, allow_nil: true
  validates :password_confirmation, presence: true, length: {minimum: 6}, on: :create
end