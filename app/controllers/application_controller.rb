class ApplicationController < ActionController::Base
  include FlashMessages

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_navbar, unless: :devise_controller?

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  protected

  def load_navbar
    @navbar = render_to_string(partial: 'shared/navbar')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
end
