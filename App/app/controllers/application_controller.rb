class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:last_name, :first_name, :patronymic, :phone, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:last_name, :first_name, :patronymic, :phone, :email, :password, :password_confirmation, :current_password, :avatar) }
  end 

  add_flash_types :created
end
