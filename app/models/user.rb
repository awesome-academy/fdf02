class User < ApplicationRecord
  enum role: {user: 0, admin: 1}
  has_many :suggests, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings[:users][:name][:max_length]}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings[:users][:email][:max_length]},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings[:users][:password][:min_length]}, allow_nil: true
end
