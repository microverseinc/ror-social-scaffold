class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:friend_id])
    current_user.request_friendship(@user)
    redirect_to stored_location_for(:user)
  end

  def cancel_friend_request
    @user = User.find(params[:id])
    friendship = Friendship.find_by(friend_id: params[:id], user_id: current_user.id)
    friendship.destroy
    flash[:notice] = 'You have canceled the friend request'
    redirect_to stored_location_for(:user)
  end

  def accept_friend_request
    @user = User.find(params[:id])
    friendship = Friendship.find_by(friend_id: current_user.id, user_id: params[:id])
    friendship.update(status: true)
    flash[:notice] = "You have accepted #{@user.name} as your friend!!!"
    redirect_to stored_location_for(:user)
  end

  def destroy
    @user = User.find(params[:id])
    friendship = Friendship.find_by(friend_id: current_user.id, user_id: params[:id])
    friendship.destroy
    flash[:notice] = "You have canceled #{@user.name} request to be your friend!"
    redirect_to stored_location_for(:user)
  end
end
