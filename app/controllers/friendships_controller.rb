class FriendshipsController < ApplicationController
  def create
    if friendship_valid?(params[:user_id], params[:friend_id])
      Friendship.create(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false)
      Friendship.create(user_id: params[:friend_id], friend_id: params[:user_id], confirmed: false)
    else
      flash[:alert] = 'Something went wrong!'
    end
    redirect_to users_url
  end

  def update
    friendship = Friendship.find_by(user_id: params[:friendships_id][0])
    friendship.update(confirmed: true)
    friendship = Friendship.find_by(friend_id: params[:friendships_id][1])
    friendship.update(confirmed: true)
    redirect_to users_url
  end

  def destroy
    friendship = Friendship.find_by(user_id: params[:friendships_id][0])
    friendship.destroy
    friendship = Friendship.find_by(friend_id: params[:friendships_id][1])
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
