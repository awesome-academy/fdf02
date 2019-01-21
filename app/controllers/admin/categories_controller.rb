class Admin::CategoriesController < ApplicationController
  layout "admin"

  before_action :load_category, except: [:index, :new, :create]

  def index
    @categories = Category.order_by_name.paginate page: params[:page],
      per_page: Settings.cates.paginate.per_page
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.cate_add_success"
      redirect_to admin_listcates_path
    else
      render :new
    end
  end

  def update
    if @category.update_attributes cate_params
      flash[:success] = t "flash.update_success"
    else
      flash[:danger] = t "flash.updated_fail"
    end
    redirect_to admin_listcates_path
  end

  def destroy
    if @category.destroy
      flash[:success] = t "flash.cate_delete_success"
    else
      flash[:danger] = t "flash.destroy_fail"
    end
    redirect_to admin_listcates_path
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    @product = Product.get_cate
    if @product.select_cate_product(@category)
      flash[:danger] = t "flash.cate_delete_fail"
      redirect_to admin_listcates_path
    elsif @product.select_cate_product(@category).nil?
      return @category
    end
  end

  def category_params
    params.require(:category).permit :name
  end
end
