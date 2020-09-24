class FriendshipsController < ApplicationController
  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: 'pending')
  end

  def update
    friendship = Friendship.find(params[:id])
    if params[:friendship_change] == 'accept_friendship_request'
      friendship.update(status: 'accepted')
      Friendship.create(user_id: friendship[:friend_id], friend_id: friendship[:user_id], status: 'accepted')
    end
  end

  def destroy
    Friendship.find(params[:id]).destroy
  end

  private

  def friendship_params
    params.require(:friendship).permit(:status)
  end
end
