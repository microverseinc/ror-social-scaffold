class FriendshipsController < ApplicationController

  def new

  end

  def create
    friend_id = params[:friend_id]
    @friendship = Friendship.find_or_create_by(user_id: current_user.id, friend_id: friend_id)
  end
end
