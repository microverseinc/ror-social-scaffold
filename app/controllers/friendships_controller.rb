class FriendshipsController < ApplicationController
  def index
    @users = User.all
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @friend_requests = current_user.recieved_requests    
  end

  def create
    
  end

  def destroy
    
  end
end
