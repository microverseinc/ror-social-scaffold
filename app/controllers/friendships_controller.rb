class FriendshipsController < ApplicationController
  include FriendshipsHelper
  def create
    current_user.requests_sent_unconfirmed.create(friend_id: params[:friend_id])
    user_requested = User.find(params[:friend_id])
    flash[:notice] = "Invitation Sent to #{user_requested.name}"
    redirect_back fallback_location: root_url
  end

  def reject
    request = current_user.requests_recieved_unconfirmed.find(params[:id])
    request.destroy
    flash[:notice] = 'Cancelled invitation'
    redirect_back fallback_location: root_url
  end

  def destroy
    request = current_user.requests_sent_unconfirmed.find(params[:id])
    request.destroy
    flash[:notice] = 'Cancelled invitation'
    redirect_back fallback_location: root_url
  end

  def update
    request = current_user.requests_recieved_unconfirmed.find_by(user_id: params[:friend_id])
    request.confirm_friend
    flash[:notice] = "Request accepted from #{User.find(params[:friend_id]).name}"
    redirect_back fallback_location: root_url
  end

  def delete
    user = User.find(params[:user_id])
    friendship(user).destroy
    flash[:notice] = "Cancelled friendship with #{user.name}"
    redirect_back fallback_location: root_url
  end
end
