class FriendshipsController < ApplicationController
  def create
    @friend_to_be = User.find(params[:friend_id])
    if current_user.id == @friend_to_be.id
      redirect_to users_path, notice: "You can't be friends to yourself, you narsistic!"
    elsif current_user.friends?(@friend_to_be)
      redirect_to users_path, notice: "You're already friends. We don't have a BFF option here..."
    else
      @friendship = current_user.friendships.new(friend_id: @friend_to_be.id, confirmed: false)
      redirect_to users_path, notice: 'You sent a friend request!' if @friendship.save
    end
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
