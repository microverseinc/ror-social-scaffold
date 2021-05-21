class FriendshipsController < ApplicationController

  def create
    user_requested = User.find(params[:friend_id])
    current_user.users_requested<< user_requested
    if params[:index] == "true"
         redirect_to users_url
    else
      redirect_to user_requested
    end
  end 


  def destroy
    request = current_user.requests_sent_unconfirmed.find(params[:id]).destroy
    user_requested = User.find(params[:user_id])
    if params[:index] == "true"
         redirect_to users_url
    else
      redirect_to user_requested
    end
  end
end
