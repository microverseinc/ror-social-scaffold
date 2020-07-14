class FriendshipsController < ApplicationController

  def create
    user = User.find_by(id: current_user)
    friend = User.find(params[:id])
    @friendship = Friendship.new(user_id: user.id, friend_id: friend.id, confirmed: false)
    # @inverse_friendship = Friendship.new(user_id: friend.id, friend_id: current_user.id, confirmed: false)
    # @inverse_friendship.save if @friendship.save
    redirect_to users_path
  end

  def update
    user = User.find_by(id: current_user)
    friend = User.find(params[:id])
    @friendship = Friendship.find_by(user_id: friend, friend_id: user)
    @inverse_friendship = Friendship.find_by(user_id: user, friend_id: friend)
    @friendship.confirm = true
    @inverse_friendship.confirm = true
    @inverse_friendship.save if @friendship.save
  end

  def destroy
    user = User.find_by(id: current_user)
    friend = User.find(params[:id])
    @friendship = Friendship.find_by(user_id: friend, friend_id: user)
    @inverse_friendship = Friendship.find_by(user_id: user, friend_id: friend)
    @inverse_friendship.delete if @friendship.delete
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
