class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])
    flash[:notice] = "Friend request has been sent to #{user.name}."
    redirect_to users_path(@friend)
  end

  def accept
    flash[:notice] = "#{user.name} accepted your frienship request." if @friendship.save
    redirect_to users_path(@friend)
  end

  private

  def user
    @friend = User.find(params[:user_id])
  end
end
