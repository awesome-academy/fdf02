class Admin::OrdersController < ApplicationController
  layout "admin"
  before_action :load_order, except: [:index, :new, :create]

  def index
    @orders = Order.paginate page: params[:page],
      per_page: Settings.cates.paginate.per_page
  end

  def edit; end

  def update
    if @user.orders.update_attributes order_params
      flash[:success] = t "flash.update_success"
    else
      flash[:danger] = t "flash.updated_fail"
    end
    redirect_to admin_listorders_path
  end

  def destroy
    if @order.destroy
      flash[:success] = t "flash.order_delete_success"
    else
      flash[:danger] = t "flash.destroy_fail"
    end
    redirect_to admin_listorders_path
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t "flash.not_found"
    redirect_to admin_users_path
  end

  def order_params
    params.require(:order).permit :status
  end
end
