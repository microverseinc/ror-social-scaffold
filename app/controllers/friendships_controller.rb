class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.send_friend_request_to(@user)

    redirect_back fallback_location: root_path, notice: 'Accepted friend request'
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.delete_friend_request_of(@user)
  end
end
