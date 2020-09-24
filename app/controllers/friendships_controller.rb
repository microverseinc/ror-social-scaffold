class FriendshipsController < ApplicationController
  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: 'pending')
    redirect_back(fallback_location: root_path)
  end

  def update
    friendship = Friendship.find(params[:id])
    if params[:friendship_change] == 'accept_friendship_request'
      friendship.update(status: 'accepted')
      Friendship.create(user_id: friendship[:friend_id], friend_id: friendship[:user_id], status: 'accepted')
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:status)
  end
end
