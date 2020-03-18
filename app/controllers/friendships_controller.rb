class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:friend_id])
    current_user.request_friendship(@user)
    redirect_to @user
  end

  
  def destroy
  end
end
