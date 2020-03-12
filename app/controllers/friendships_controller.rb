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
    friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: params[:user_id])
    friendship.update(confirmed: true)
    Friendship.create(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: true)
    redirect_to users_url
  end

  def destroy
    friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: params[:user_id])
    if friendship.confirmed
      friendship2 = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
      friendship2.destroy
    end
    friendship.destroy
    redirect_to users_url
  end

  private

  def friendship_valid?(user_id, friend_id)
    combination1 = !Friendship.exists?(user_id: user_id, friend_id: friend_id)
    combination2 = !Friendship.exists?(user_id: friend_id, friend_id: user_id)
    combination1 && combination2
  end
end
