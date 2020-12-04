class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    friendship = Friendship.create(user_id: current_user.id, friend_id: friend.id)
    flash[:success] = 'Friendrequest sent'
    redirect_to user_path(friend)
  end

  def update
    user = User.find(params[:user_id])
    current_user.confirm_friend(user)
    redirect_to user_path(user)
  end

  def destroy
  end

  private

  def friendship_params
    params.require(:friendships).permit(:user_id, :friend_id)
  end

end
