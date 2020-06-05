class FriendshipsController < ApplicationController
  def create
    # user A requests to be a friend of user B
    # User B must accept it later
    @friendship = current_user.friendship.build(friend_id: params[:id])
    @friendship.save
    redirect_to root_path
  end


end