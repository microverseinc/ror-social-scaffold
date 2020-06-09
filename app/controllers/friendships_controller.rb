class FriendshipsController < ApplicationController
  def index
    @friend_list = current_user.friendships.all
  end

  def create
    @friend = Friendship.create(friendship_params)
  end

  def destroy
    @relationship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
  end

  def update
    # TODO: change column to TRUE when accept
  end

  private
  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
