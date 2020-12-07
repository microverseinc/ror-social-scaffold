class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    friendship = Friendship.create(user_id: current_user.id, friend_id: friend.id)
    flash[:success] = 'Friend request sent!'
    redirect_to user_path(friend)
  end

  def update
    friendship = Friendship.find(params[:id])
    friendship.update!(confirmed: true)
    redirect_to user_path(friendship.user_id)
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    flash[:danger] = 'Canceled Friend request!'
    redirect_to user_path(friendship.friend_id)
  end

  private

  def friendship_params
    params.require(:friendships).permit(:user_id, :friend_id)
  end

end
