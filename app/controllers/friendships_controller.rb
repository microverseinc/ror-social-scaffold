class FriendshipsController < ApplicationController

  def create
    user_requested = User.find(params[:friend_id])
    current_user.users_requested<< user_requested
    redirect_to user_requested
  end 


  def destroy
    request = current_user.requests_sent_unconfirmed.find(params[:id]).destroy
    user_requested = User.find(params[:user_id])
    redirect_to user_requested
  end
end
