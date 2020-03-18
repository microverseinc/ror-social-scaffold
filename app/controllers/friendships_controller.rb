class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:friend_id])
    current_user.request_friendship(@user)
    redirect_to @user
  end
 
   def cancel_friend_request
    @user = User.find(params[:id])
    @user.inverse_friendships.delete(current_user.id)
    current_user.requested_friends.delete(@user)
    redirect_to @user
   end

   def accept_friend_request
      @user = User.find(params[:id])
      friendship = Friendship.find_by(friend_id: params[:user_id], user_id: current_user.id)
      friendship.update(status: true)
      flash[:notice] = "You have accepted #{user.name} as your friend!!!"
      redirect_to @user
   end
  
  def destroy
  end
end
