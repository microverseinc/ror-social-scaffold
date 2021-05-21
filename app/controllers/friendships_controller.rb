class FriendshipsController < ApplicationController
  def create
    new_request = current_user.requests_sent_unconfirmed.build(friend_id: params[:friend_id])
    user_requested = User.find(params[:friend_id])
    current_user.requests_sent_unconfirmed << new_request
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
    request = current_user.requests_recieved_unconfirmed.find_by(user_id: params[:user_id])
    request.update(confirmed: true)
    flash[:notice] = "Request accepted from #{User.find(params[:user_id]).name}"
    redirect_back fallback_location: root_url
  end

  def delete; end
end
