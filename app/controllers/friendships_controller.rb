class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    @friendship = current_user.friendships.new(friend: friend)

    if @friendship.save
      render
  end
end
