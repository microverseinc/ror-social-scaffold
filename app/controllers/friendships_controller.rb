class FriendshipsController < ApplicationController

  def create
    requestee = User.find(params[:friend_id]) 
    current_user.users_requested << requestee
    redirect_to requestee
  end

end
