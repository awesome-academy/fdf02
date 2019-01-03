class StaticPagesController < ApplicationController
  def index
    @products = Product.includes(:images).paginate page: params[:page],
      per_page: Settings.products.paginate_default
    @q = Product.ransack(params[:q])
    @searchs = @q.result(distinct: true)
    @searchs = @searchs.select_cate_product(params[:sltCategory]) if params[:sltCategory]
    if session[:cart]
      @cart_products = Product.select_id_product session[:cart].keys
      return if @cart_products
    end
  end

  def about; end
end
