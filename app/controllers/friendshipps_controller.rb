class FriendshippsController < ApplicationController
  include FriendshippsHelper

  def create
    return if friend_request_received?(User.find(params[:friend_id]))
    return if friend_request_sent?(User.find(params[:friend_id]))     
    @friendship = current_user.friendshipps.build(friend_id: params[:friend_id])
      if @friendship.save
        flash[:notice] = 'Request sent'
        redirect_to root_path
      else
        flash[:notice] = 'Unable to send request'
      end
  end

  def accept
    friend = User.find(params[:friend_id])
    current_user.confirm_friend(friend)
    friend.request_accepted(current_user)
    redirect_to users_path, notice: 'friend request accepted.'
  end

  def decline_friend
    @friendship = Friendshipp.
              find_by(user_id:params[:user_id], friend_id: current_user.id, confirmed: nil)
    return unless @friendship
    @friendship.destroy
    flash[:notice] = 'Friend request declined'
  end
   
  private

  def find_friendship
    @friendship_id = Friendshipp.find(params[:id])
  end   
      
end
