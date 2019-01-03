class UsersController < ApplicationController
  load_and_authorize_resource

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

  def destroy; end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :phone, :address,
      :password_confirmation
  end
end
