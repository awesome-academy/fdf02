class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum role: {user: 0, admin: 1}
  has_many :suggests, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy

  before_save :downcase_email

  validates :name, presence: true,
    length: {maximum: Settings[:users][:name][:max_length]}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings[:users][:email][:max_length]},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings[:users][:password][:min_length]}
  validates :phone, presence: true,
    length: {
        minimum: Settings.users.phone.min_length,
        maximum: Settings.users.phone.max_length
      }, numericality: true

  scope :order_by_name, ->{order name: :ASC}

  # def self.digest string
  #   cost =
  #     if ActiveModel::SecurePassword.min_cost
  #       BCrypt::Engine::MIN_COST
  #     else
  #       BCrypt::Engine.cost
  #     end
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # def authenticated? attribute, token
  #   digest = digest("#{attribute}_digest")
  #   return false if digest.nil?
  #   BCrypt::Password.new(digest).is_password?(token)
  # end

  def downcase_email
    email.downcase! if attribute_present? "email"
  end
end
