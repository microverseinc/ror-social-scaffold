class FriendshipsController < ApplicationController

  def create
    new_request = current_user.requests_sent_unconfirmed.build(friend_id:params[:friend_id])
    user_requested = User.find(params[:friend_id])
    if new_request.valid?
      current_user.requests_sent_unconfirmed << new_request 
      flash[:notice] = "Invitation Sent to #{user_requested.name}"
    else
      flash[:error] = "Invitation failed, invalid request"
    end

    if params[:index] == "true"
      redirect_to users_url
    else
      redirect_to user_requested
    end
  end 


  def destroy
    request = current_user.requests_sent_unconfirmed.find(params[:id]).destroy
    user_requested = User.find(params[:user_id])
    flash[:notice] = "Cancelled invitation to #{user_requested.name}"
    if params[:index] == "true"
         redirect_to users_url
    else
      redirect_to user_requested
    end
  end


  def accept
    
  end
end
