class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname])
  end

  def after_sign_in_path_for(resource_or_scope)
    houses_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path  # i.e. '/users/sign_in'
  end
end
