class Admin::UsersController < ApplicationController
  layout "admin"

  before_action :load_user, except: [:index, :new, :create]

  def index
    @users = User.order_by_name.paginate page: params[:page],
      per_page: Settings.users.paginate.per_page
  end

  def edit; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.welcome"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    debugger
    if @user.update_attributes user_params
      flash[:success] = t "flash.update_success"
    else
      flash[:danger] = t "flash.updated_fail"
    end
    redirect_to admin_users_path
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.destroy"
    else
      flash[:danger] = t "flash.destroy_fail"
    end
    redirect_to admin_users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.not_found"
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :phone, :address,
      :password_confirmation, :role
  end
end
