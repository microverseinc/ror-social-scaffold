class FriendshipsController < ApplicationController
  def create
    Friendship.friend_requests(current_user, @friend)
    flash[:success] = 'Friend request has been sent #{@friend.name}.'
    redirect_to user_path(@friend)
  end

  private

  def_user
    @friend = User.find(params[:id])
  end
  
end