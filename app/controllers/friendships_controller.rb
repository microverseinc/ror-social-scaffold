class FriendshipsController < ApplicationController
  def create
    current_user.add_friend(params[:user_id])
    redirect_to users_path
  end

  def destroy
    current_user.reject_request(params[:friend_id])
    redirect_to users_path
  end

  def update
    current_user.accept_request(params[:friend_id])
    redirect_to users_path
  end

  private

  def friendship_params
    params.permit(:friend_id)
  end
end
