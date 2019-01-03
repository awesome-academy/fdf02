class Admin::OrdersController < ApplicationController
  layout "admin"
  before_action :load_order_show, only: [:show, :destroy]
  before_action :load_order_update, only: :update

  def index
    @orders = Order.newest.paginate page: params[:page],
      per_page: Settings.cates.paginate.per_page
  end

  def edit; end

  def show; end

  def update
    if @order.update_attributes id: @order.id, status: @order.status
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

  def load_order_update
    @order = Order.find_by id: params[:id]
    if @order
      if @order.incoming?
        @order.status = 1
      elsif @order.in_progress?
        @order.status = 2
      elsif @order.finished?
        @order.status = 2
      end
    else
      flash[:danger] = t "flash.not_found"
      redirect_to admin_users_path
    end
  end

  def load_order_show
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t "flash.not_found"
    redirect_to admin_users_path
  end
end
