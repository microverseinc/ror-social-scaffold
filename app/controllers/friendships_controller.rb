class FriendshipsController < ApplicationController
  def create
    friendship = current_user.friendships.create(friend_id: params[:id])
    friendship.save
    redirect_to user_path(params[:id])
  end

  def update
    current_user.confirm_friend(User.find(params[:id]))
    redirect_to user_path(params[:id])
  end
end
