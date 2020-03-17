class FriendshipsController < ApplicationController

  def index    
    @friend_requests = Friendship.where(friend_id: current_user.id) 
  end

  def create
    @friend = User.find_by(id: params[:friendships][:friend])
    return redirect_to root_path if current_user.cannot_add?(@friend)
    
    current_user.friendships.create(friend_id: @friend.id)
    redirect_to request.referrer
  end   
end
