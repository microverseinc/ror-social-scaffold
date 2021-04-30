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
    Friendship.breakup(@user1, @friend)
    flash[:notice] = "Friend request from #{@friend.name} has been declined."
    redirect_to user_path(@user1)
  end

  def destroy
    Friendship.breakup(@user1, @friend)
    flash[:notice] = "#{@friend.name} has been successfully removed from your friends list."
    redirect_to user_path(@user1)
  end

  private

  def def_user
    @user1 = current_user
    @friend = User.find(params[:id])
  end
end
