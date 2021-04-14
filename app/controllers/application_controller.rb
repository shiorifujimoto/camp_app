class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name, :profile])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name, :profile, :avatar])
  end
end
