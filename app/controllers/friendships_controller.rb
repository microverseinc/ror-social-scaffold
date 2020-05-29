class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    @friendship.save
    redirect_to users_path
  end

  def new
    redirect_to users_path
  end

  def accept
    current_user.confirm_friend(User.find_by(id: params[:user_id]))
    redirect_to users_path
  end
end
