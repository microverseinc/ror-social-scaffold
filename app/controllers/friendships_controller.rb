class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    current_user.request_friendship(friend)
    redirect_to stored_location_for(:user) || root_path
  end

  def cancel_friend_request
    friend = User.find(params[:id])
    destroy_friendship(current_user, friend)
    flash[:notice] = 'You have canceled the friend request'
    redirect_to stored_location_for(:user) || root_path
  end

  def accept_friend_request
    friend = User.find(params[:id])
    accept_friendship(friend, current_user)

    # Making sure both row are created
    current_user.request_friendship(friend)
    accept_friendship(current_user, friend)

    flash[:notice] = "You have accepted #{friend.name} as your friend!!!"
    redirect_to stored_location_for(:user) || root_path
  end

  def destroy
    friend = User.find(params[:id])
    destroy_friendship(current_user, friend)

    # Making sure both row are deleted
    destroy_friendship(friend, current_user)

    flash[:notice] = "You have canceled #{friend.name} request to be your friend!"
    redirect_to stored_location_for(:user) || root_path
  end

  def reject
    friend = User.find(params[:id])
    destroy_friendship(friend, current_user)

    flash[:notice] = "You have canceled #{friend.name} request to be your friend!"
    redirect_to stored_location_for(:user) || root_path
  end
end
