class SuggestsController < ApplicationController
  before_action :load_suggest, only: :destroy

  def show
    @user = User.find_by id: current_user[:id]
    if @user
      @suggests = @user.suggests.newest
      return @suggests
    else
      flash[:danger] = t "flash.suggest_notfound"
      redirect_to root_path
    end
  end

  def index
    @suggest = Suggest.new
  end

  def create
    if user_signed_in?
      @suggest = Suggest.new(user_id: current_user[:id], content: suggest_params[:content])
      @suggest.save
      flash[:success] = t "flash.suggest_success"
      redirect_to suggests_show_path
    else
      flash[:danger] = t "flash.suggest_fail"
      redirect_to root_path
    end
  end

  def destroy
    if @suggest.destroy
      flash[:success] = t "flash.suggest_delete_success"
    end
    redirect_to suggests_show_path
  end

  private

  def suggest_params
    params.require(:suggest).permit :content
  end

  def load_suggest
    @suggest = Suggest.find_by id: params[:id]
    return if @suggest.incoming?
    flash[:danger] = t "flash.suggest_delete_fail"
    redirect_to suggests_show_path
  end
end
