class FriendshipsController < ApplicationController
  def index
    # @friend_list = current_user.friendships.where('acceptance =?', true)
    @friend_list = current_user.friendships.is_friend
  end

  def create
    @friend = Friendship.create(friendship_params)
  end

  def destroy
    @relationship = Friendship.find_by(
      user_id: current_user.id, 
      friend_id: params[:id])
  end

  def update
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.update(acceptance: true)
    redirect_to friendships_path
  end

  private
  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
