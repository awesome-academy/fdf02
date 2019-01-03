class OrdersController < ApplicationController
  def show
    @user = User.find_by id: session[:user_id]
    if @user
      @orders = @user.orders
      return @orders
    flash[:danger] = t "flash.order_notfound"
    redirect_to root_path
  end
end
