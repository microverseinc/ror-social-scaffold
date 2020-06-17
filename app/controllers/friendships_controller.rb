class FriendshipsController < ApplicationController
  def index
    @friend_list = Friendship.all
  end

  def create
    @friend = Friendship.create(friendship_params)
  end

  def destroy
    @relationship = Friendship.find(params[:id])
    @relationship.destroy
    redirect_to friendships_path
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(acceptance: true)

    redirect_to friendships_path
  end

  private
  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
