class Admin::ProductsController < ApplicationController
  layout "admin"

  before_action :load_product, except: [:index, :new, :create]

  def index
    @products = Product.includes(:images).order_by_name.paginate page: params[:page],
      per_page: Settings.products.paginate.per_page
  end

  def new
    @product = Product.new
    @image = @product.images.build
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
      flash[:success] = t "flash.product_delete_success"
    else
      flash[:danger] = t "flash.destroy_fail"
    end
    redirect_to admin_listproducts_path
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    @check_product = OrderDetail.find_by product_id: @product[:id]
    if @check_product
      if @check_product.order.finished?
        return @product
      else
        flash[:danger] = t "flash.product_delete_fail"
        redirect_to admin_listproducts_path
      end
    elsif @check_product.nil?
      return @product
    end
  end

  def product_params
    params.require(:product).permit :name, :price, :description,
      images_attributes: [:id, :product_id, :picture]
  end
end
