class Admin::ProductsController < ApplicationController
  layout "admin"

  before_action :load_product, except: [:index, :new, :create]

  def index
    @products = Product.includes(:images).order_by_name.paginate page: params[:page],
      per_page: Settings.products.paginate.per_page
  end

  def new
    @product = Product.new
  end

  def create; end

  def edit; end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "flash.update_success"
    else
      flash[:danger] = t "flash.updated_fail"
    end
    redirect_to admin_listproducts_path
  end

  def destroy
    if @product.destroy
      flash[:success] = t "flash.cate_delete_success"
    else
      flash[:danger] = t "flash.destroy_fail"
    end
    redirect_to admin_listproducts_path
  end

  private

  def load_product
    @product = Product.includes(:images).find_by id: params[:id]
    return if @product
    flash[:danger] = t "flash.not_found_cate"
    redirect_to admin_listproducts_path
  end

  def product_params
    params.require(:product).permit :name, :price, :description
  end
end
