class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :order_by_name, ->{order name: :ASC}
end
