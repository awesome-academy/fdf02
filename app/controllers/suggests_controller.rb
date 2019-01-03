class SuggestsController < ApplicationController
  def show
    @user = User.find_by id: session[:user_id]
    if @user
      @suggests = @user.suggests
      return @suggests
    end
    flash[:danger] = t "flash.suggest_notfound"
    redirect_to root_path
  end
end
