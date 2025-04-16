class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception # Needed unless you're API-only

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :province_id, :address]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
  def after_sign_in_path_for(resource)
    root_path # or cart_path or dashboard_path, wherever you want
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  
end