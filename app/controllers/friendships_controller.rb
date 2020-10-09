class FriendshipsController < ApplicationController

  def add_friend
    @user = current_user
    @frienship = current_user.friendships.create(friend_id: params[:id])
    redirect_to user_path
  end

  def accept_request
    @friendship = Friendship.find_by(user_id: 6, friend_id: current_user.id)
    @friendship.confirmed = true
    @friendship.save
    current_user.friendships.create(friend_id: 6, confirmed: true)
  end
end
