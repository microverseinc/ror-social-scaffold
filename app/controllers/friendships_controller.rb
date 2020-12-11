class FriendshipsController < ApplicationController
  include ApplicationHelper

  def index
    @friendship = current_user.Friendship.all
  end

  def create
    @user = User.find(params[:requester_id])
    @friendships = current_user.friendships.new
    @friendships.friend_id = @user.id
    @friendships.requester_id = current_user.id
    @friendships.save

    redirect_to users_path, notice: 'Friend Request sent!'
  end

  def destroy
    friendship = Friendship.find_by(requester_id: params[:requester_id], friend_id: params[:friend_id])
    friendship.destroy
    redirect_to users_path, notice: 'Friend request cancelled'
  end

  def update
    if params[:accept]
    @friendship = Friendship.find_by(requester_id: params[:requester_id])
    @friendship.confirmed = true
    @friendship.save


    redirect_to users_path, notice: 'Friend request was successfully confirmed.'
    else
      destroy
    end
  end
end
