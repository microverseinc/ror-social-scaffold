class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id])
    if @friendship.save
      redirect_to users_path, notice: 'Friend request was sent!!'
    else
      redirect_to users_path, notice: 'Unable to send friend request at this time.'
    end
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    # @friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: params[:user_id]) if @friendship.nil?
    @friendship.destroy

    redirect_to users_path, notice: 'Friend removed!'
  end

  def approve
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    @user.confirm_friend(@friend)

    redirect_to user_path(params[:user_id])
  end
end
