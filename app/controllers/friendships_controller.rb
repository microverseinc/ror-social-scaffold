class FriendshipsController < ApplicationController
  def create
    # User.friend_requests
    @friendship = current_user.friendships.new(friend_id: params[:user_id])
    flash[:notice] = "Friend request has been sent to #{user.name}."
 
    redirect_to users_path(@friend)
  end

  def accept
    if @friendship.save
      flash[:notice] = "#{user.name} accepted your frienship request."
    end
    redirect_to users_path(@friend)
  end

  private

  def user
    @friend = User.find(params[:user_id])
  end
end
