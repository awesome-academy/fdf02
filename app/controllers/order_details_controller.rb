class OrderDetailsController < ApplicationController
  def create
    if user_signed_in?
      @order = Order.new(user_id: current_user[:id], total: params[:total])
      @user = User.find_by(id: current_user[:id])
      if @order.save
        UserMailer.welcome_email(@user).deliver_now
      end
      session[:cart].each do |key, value|
        @order_details = @order.order_details.create(product_id: key,
          quantity: value)
        product = Product.find_by id: key
        total_price = @order_details.quantity * product.price
        @order_details.update_attributes(total_price: total_price)
      end
      destroy_session_cart
      flash[:success] = t "flash.order_details_success"
    else
      flash[:danger] = t "flash.order_details_fail"
    end
    redirect_to root_path
  end

  def destroy_session_cart
    session.delete(:cart)
  end
end
