class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  private

  def get_friends(user)
    user.inviters.where(friendships: { status: true })
  end

  def check_friendship(logged_user, user)
    Friendship.exists?(inviter_id: logged_user, invitee_id: user, status: true)
  end

  def check_invitation(logged_user, user)
    Friendship.exists?(inviter_id: logged_user, invitee_id: user) || Friendship.exists?(inviter_id: user, invitee_id: logged_user)
  end
end
