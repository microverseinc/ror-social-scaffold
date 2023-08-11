class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:format])
    @friendship = current_user.friendships.create(friend_id: params[:format])
    @friendship.save
    redirect_back(fallback_location: root_path)
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed = true
    @friendship.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end
end
