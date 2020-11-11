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

  def accept_friend
    @friendship = Friendshipp.
              find_by(user_id:params[:friend_id], friend_id: current_user.id, confirmed: nil)
    return unless @friendship
    @friendship.confirmed = true
    if @friendship.save
      flash[:notice] = 'Friend request accepted'
      @friendship2 = current_user.pending_friends.build(friend_id: params[:user_id],confirmed: true)
      redirect_to current_user_path
    else
      flash[:notice] = 'Friend request could not be accepted'
    end
  end
  
  def decline_friend
    @friendship = Friendshipp.
              find_by(user_id:params[:user_id], friend_id: current_user.id, confirmed: nil)
    return unless @friendship
    @friendship.destroy
    flash[:notice] = 'Friend request declined'
  end
      
      
end
