class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :order_details, dependent: :destroy

  scope :join_images, ->{joins :images}
  scope :order_by_name, ->{order name: :DESC}
  scope :select_id_product, ->(id_product){where id: id_product}
  scope :select_cate_product, ->(cate_product){where(category_id: cate_product)}
end
