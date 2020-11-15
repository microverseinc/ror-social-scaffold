class FriendshippsController < ApplicationController
  include FriendshippsHelper

  def create
    return if friend_request_received?(User.find(params[:friend_id]))
    return if friend_request_sent?(User.find(params[:friend_id]))     
    @friendship = current_user.friendshipps.build(friend_id: params[:friend_id])
      if @friendship.save
        flash[:notice] = 'Request sent'
        redirect_to users_path
      else
        flash[:notice] = 'Unable to send request'
      end
  end

  def accept
    @friendship = Friendshipp.find_by(user_id: params[:friend_id], friend_id: current_user.id, confirmed: nil)
    return unless @friendship
    @friendship.confirmed = true
    if @friendship.save
      flash[:notice] = 'Friend accepted successfuly'
      @friendship2 = Friendshipp.create(user_id: current_user.id, friend_id: params[:friend_id], confirmed: true)
      redirect_to users_path
    else
      flash[:notice] = "Couldn't accept friend request"
    end
  end

  def reject
    friendship = current_user.inverse_friendshipps.where(user_id: params[:friend_id])[0]
    friendship.destroy
    redirect_to users_path, notice: 'friend request rejected.'
  end
   
  private

  def find_friendship
    @friendship_id = Friendshipp.find(params[:id])
  end   
      
end
