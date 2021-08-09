class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :search_friendship

  def search_friendship(user_id, friend_id)
    return if user_id == friend_id

    friendship = Friendship.find_by(user_id: user_id, friend_id: friend_id)

    friendship = Friendship.find_by(user_id: friend_id, friend_id: user_id) if friendship.nil?

    if friendship.nil?
      nil
    else
      friendship.id
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
end
