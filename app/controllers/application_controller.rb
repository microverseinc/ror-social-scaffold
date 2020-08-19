class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :already_invited?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  private

  def already_invited?(user_id)
    if current_user.friendships.find_by(invitee_id: user_id, status: false)
      true
    else
      false
    end
  end
end
