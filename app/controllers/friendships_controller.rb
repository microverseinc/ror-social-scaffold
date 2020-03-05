class FriendshipsController < ApplicationController

  def create
    if friendship_valid?(params[:user_id], params[:friend_id])
      Friendship.create(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false)
    else
      flash[:alert] = 'Something went wrong!'
    end
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

  private

  def friendship_valid?(user_id, friend_id)
    !Friendship.exists?(user_id: user_id, friend_id: friend_id) && !Friendship.exists?(user_id: friend_id, friend_id: user_id)
  end
end
