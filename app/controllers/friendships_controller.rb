class FriendshipsController < ApplicationController
 

  def create
    current_user.friend_requests
    flash[:notice] = "Friend request has been sent #{user.name}."
    redirect_to user_path(current_user.id)
    
  end

  private

  def user
    @friend = User.find(params[:user_id])
  end

end