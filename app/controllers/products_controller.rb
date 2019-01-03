class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    @products = Product.includes(:images).paginate page: params[:page],
      per_page: Settings.products.paginate.per_page
    @q = Product.ransack(params[:q])
    @searchs = @q.result(distinct: true)
    @searchs = @searchs.select_cate_product(params[:sltCategory]) if params[:sltCategory]
    if session[:cart]
      @cart_products = Product.select_id_product session[:cart].keys
      return if @cart_products
    end
  end

  def show
    if @product
      respond_to do |format|
        format.html{return @product}
        format.js
      end
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "flash.not_found"
    redirect_to root_path
  end

  def search_params
    params.permit :sltCategory, :priceto, :pricefrom
  end
end
