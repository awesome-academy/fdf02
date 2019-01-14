module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def logged_in?
    current_user.present?
  end

  # Returns true if the given user is the current user.
  def current_user? user
    user == current_user
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by id: session[:user_id] if session[:user_id]
    end
  end

  def check_login user, params
    if user &.authenticate(params[:session][:password])
      log_in user
      flash.now[:success] = I18n.t "flash.login_success"
      if current_user.admin?
        redirect_to(admin_root_path)
      else
        redirect_to user
      end
    else
      flash.now[:danger] = I18n.t "flash.invalid"
      render :new
    end
  end
end
