class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create(fr_id)
    @friendship = Friendship.new(user_id: current_user.id, friend_id: fr_id, status: false)

    @friendship.save
    redirect_to users_path
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.confirm_friend

    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])

    @friendship.delete

    redirect_to users_path
  end
end
