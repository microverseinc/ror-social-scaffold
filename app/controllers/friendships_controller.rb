class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    @friendship.save
    redirect_to users_path
  end

  def new
    redirect_to users_path
  end

  def accept
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
  end
end
