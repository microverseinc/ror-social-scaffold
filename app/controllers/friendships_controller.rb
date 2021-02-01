class FriendshipsController < ApplicationController
 
  def index
    @friends = current_user.friends
  end

  def create
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id], confirmed: false)
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
