class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
  end

  def create
    Friendship.create(friendship_params)
    redirect_to users_path
  end

  def destroy
    another = User.find params[:user_id]
    current_user.friends.delete(another)
    redirect_to users_path
  end

  def friendship_params
    params.require(:friendships).permit(:user_id, :friend_id, :confirmed)
  end
end
