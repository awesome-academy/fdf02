class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :admin_user, only: :destroy
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    return if @user
    render html: t("controller.users.empty")
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controller.users.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "flash.update"
      redirect_to @user
    else
      render :edit
    end
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "flash.log_in"
    redirect_to login_path
  end

  def destroy; end

  def destroy; end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :phone, :address,
      :password_confirmation
  end

  def correct_user
    redirect_to(root_path) unless current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.not_found"
    redirect_to root_path
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
