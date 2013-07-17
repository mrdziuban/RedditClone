class User < ActiveRecord::Base
  attr_accessible :password_digest, :username, :password, :password_confirmation
  has_secure_password

  has_many :subs, foreign_key: :moderator

  validates :username, presence: true, uniqueness: {scope: :username}
  validates :password, presence: true, length: {minimum: 6}, on: :create, confirmation: true
  validates :password_confirmation, presence: true, length: {minimum: 6}, on: :create
end