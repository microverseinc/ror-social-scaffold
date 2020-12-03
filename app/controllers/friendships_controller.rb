class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friendships = Friendship.where(friend_id: current_user.id)
    @pending_friends = current_user.pending_friends
  end

  def create
    @friendship = current_user.friendships.build(friendship_params)
    if @friendship.save
      flash[:notice] = 'You have successfuly sent a friend request'
    else
      flash[:alert] = 'Friend request was not successful'
    end
    redirect_to root_path
  end

  def destroy
    Friendship.find(params[:id]).destroy
    flash[:notice] = 'You declined the request!'
    redirect_to root_path
  end

  private

  def friendship_params
    params.permit(:friend_id)
  end
end
