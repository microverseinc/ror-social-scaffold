class FriendshipsController < ApplicationController

  def create
    Friendship.create(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false)
    redirect_to users_url
  end

  def update
    friendship = Friendship.find(params[:id])
    friendship.update(confirmed: true)
    redirect_to users_url
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_to users_url
  end
end
