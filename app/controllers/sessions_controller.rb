class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    check_login user, params
  end

  def destroy
    if logged_in?
      log_out
      session.delete(:cart)
    end
    redirect_to root_path
  end
end
