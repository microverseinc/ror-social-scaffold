class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:friend_id])
    current_user.request_friendship(@user)
    redirect_to @user
  end
 
   def cancel_friend_request
    @user = User.find(params[:id])
    current_user.pending_requested_friendship.delete(@user)
    redirect_to @user
   end
  
  def destroy
  end
end
