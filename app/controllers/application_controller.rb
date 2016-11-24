class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_user

  include CanCan::ControllerAdditions

  def home

  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation,
      :avatar]
    added_attrs_2 = [:email, :password, :remember_me]
    added_attrs_3 = [:username, :email, :password, :password_confirmation,
      :avatar, :feelings]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs_3
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs_2
  end

  private
  def after_sign_in_path_for user
    current_user.is_admin? ? admin_root_url : root_url
  end

  def layout_by_user
    if user_signed_in? && current_user.is_admin?
      "admin"
    elsif user_signed_in? && !current_user.is_admin?
      "user"
    else
      "application"
    end
  end

  def check_null object
    unless object
      flash[:danger] = t "error.fail"
      redirect_to root_url
    end
  end

  def current_ability
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize
    Ability.new current_user, controller_namespace
  end
end
