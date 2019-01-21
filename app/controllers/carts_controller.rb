class CartsController < ApplicationController
  before_action :load_cart, only: [:show, :checkout]

  def create
    check_current_cart params[:product_id]
    if session[:cart]
      @cart_products = Product.select_id_product session[:cart].keys
      if @cart_products
        respond_to do |format|
          format.html{return @cart_products}
          format.js
        end
      end
    end
  end

  def check_current_cart product_id
    if session[:cart]
      if session[:cart].key?(product_id.to_s)
        session[:cart][product_id.to_s] += 1
      else
        session[:cart].store(product_id.to_s, 1)
      end
      flash[:success] = t "flash.cart_add_item"
    else
      session[:cart] = {}
    end
  end

  def show; end

  def checkout; end

  def cart_update_item
    session[:cart][params[:product_id]] = params[:quantity].to_i
    if session[:cart]
      @cart_products = Product.select_id_product session[:cart].keys
      if @cart_products
        respond_to do |format|
          format.html{return @cart_products}
          format.json { render json: @cart_products.to_json }
          format.js
        end
      end
    end
  end

  def cart_delete_item
    session[:cart].delete(params[:product_id].to_s)
    if session[:cart]
      @cart_products = Product.select_id_product session[:cart].keys
      if @cart_products
        respond_to do |format|
          format.html{return @cart_products}
          format.js
        end
      end
    end
  end

  def destroy
    session.delete(:cart)
  end

  private

  def load_cart
    if session[:cart]
      @cart_products = Product.select_id_product session[:cart].keys
      if @cart_products
        respond_to do |format|
          format.html{return @cart_products}
          format.js
        end
      end
    end
    flash[:danger] = t "flash.cart_notfound"
    redirect_to root_path
  end
end
