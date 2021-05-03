class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :def_user, only: %i[create accept decline destroy]

  def create
    Friendship.request(@user1, @friend)
    flash[:notice] = "Friend request has been sent to #{@friend.name}."
    redirect_to user_path(@friend)
  end

  def accept
    Friendship.accept(@user1, @friend)
    flash[:notice] = "Friend request from #{@friend.name} has been accepted."
    redirect_to user_path(@user1)
  end

  def decline
    @user1.requested_friends.delete(User.find(@friend.id))
    @friend.pending_friends.delete(User.find(@user1.id))
    flash[:notice] = "You have rejected #{@friend.name}'s friend request."
    redirect_to user_path(@user1)
  end

  def destroy
    @user1.friends.delete(User.find(@friend.id))
    @friend.friends.delete(User.find(@user1.id))
    flash[:notice] = "#{@friend.name} has been removed from your friends."
    redirect_to user_path(@user1)
  end

  private

  def def_user
    @user1 = current_user
    @friend = User.find(params[:id])
  end
end
