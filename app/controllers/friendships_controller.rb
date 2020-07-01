class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
  end

  def create
    # byebug
    @friendship = Friendship.new(friendship_params)

    redirect_to root_path, notice: "Request was successfully sent to #{@friendship.friend.name}" if @friendship.save
  end

  def destroy
    @user = User.find(params[:id])
    @friendship = current_user.find_friendship(@user)

    flash[:alert] = "You have unfriended #{@user.name}" if @friendship.destroy
    redirect_to users_path
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
