class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :order_details

  scope :join_images, ->{joins :images}
  scope :order_by_name, ->{order name: :DESC}
  scope :select_id_product, ->(id_product){where id: id_product}
  scope :select_cate_product, ->(cate_product){where category_id: cate_product}
  scope :get_cate, ->{joins :order_details}
  scope :starts_with, ->(product_name){ where("name like ?", "#{product_name}%")}

  accepts_nested_attributes_for :images

  scope :search_price, lambda {|price_from, price_to| where("price >= ? AND price <= ?", price_from, price_to)}
  scope :search_from, ->(price_from){where("price >= ?","#{price_from}%")}
  scope :search_to, ->(price_to){where("price <= ?","#{price_to}%")}

  scope :cakes, (lambda do
    select(:id, :name, :price, "images.picture")
    .joins(:category, :images)
    .where(categories: {name: "banh"})
    .order(created_at: :DESC)
    .limit(8)
  end)

  scope :coffees, (lambda do
    select(:id, :name, :price, "images.picture")
    .joins(:category, :images)
    .where(categories: {name: "caphe"})
    .order(created_at: :DESC)
    .limit(8)
  end)

  scope :teas, (lambda do
    select(:id, :name, :price, "images.picture")
    .joins(:category, :images)
    .where(categories: {name: "trasua"})
    .order(created_at: :DESC)
    .limit(8)
  end)

  def self.search search
    if search
      if search[:pricefrom].present? && search[:priceto].present?
        results = self.search_price(search[:pricefrom], search[:priceto])
      elsif search[:priceto].present?
        result = self.search_to(search[:priceto])
      elsif search[:pricefrom].present?
        result = self.search_from(search[:pricefrom])
      elsif result.present?
        results = results.select_cate_product(search[:sltCategory]) if search[:sltCategory].present?
      elsif result.blank?
        results= self.select_cate_product(search[:sltCategory]) if search[:sltCategory].present?
      end
    else
      where(nil)
    end
  end
end
