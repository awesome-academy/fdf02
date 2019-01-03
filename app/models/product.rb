class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :order_details, dependent: :destroy

  scope :order_by_name, ->{order name: :DESC}
end
