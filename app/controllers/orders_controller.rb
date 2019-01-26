class OrdersController < ApplicationController
  before_action :load_order, only: :destroy

  def show
    @user = User.find_by id: session[:user_id]
    if @user
      @orders = @user.orders.newest
      return @orders
    end
    flash[:danger] = t "flash.order_notfound"
    redirect_to root_path
  end

  def destroy
    if @order.destroy
      flash[:success] = t "flash.order_cancel_success"
    end
    redirect_to orders_show_path
  end

  def load_order
    @order = Order.find_by id: params[:id]
    if @order.incoming?
      return @order
    elsif @order.in_progress?
      flash[:danger] = t "flash.order_cancel_fail_1"
    elsif @order.finished?
      flash[:danger] = t "flash.order_cancel_fail_2"
    end
    redirect_to orders_show_path
  end
end
