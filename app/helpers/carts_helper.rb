module CartsHelper
  def quantity_in_carts
    quantity = 0
    session[:cart].each do |index, value|
      quantity += 1
    end
    quantity
  end

  def total_order
    products = Product.select_id_product session[:cart].keys
    total_price_order = 0
    products.each do |item|
      total_price_order += item.price * session[:cart][item.id.to_s]
    end
    total_price_order
  end
end
