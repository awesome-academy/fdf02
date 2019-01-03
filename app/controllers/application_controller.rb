class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  public

  def configure_permitted_parameters
    add_params = [:name, :address, :phone]
    devise_parameter_sanitizer.permit :sign_up, keys: add_params
    devise_parameter_sanitizer.permit :account_update, keys: add_params
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
