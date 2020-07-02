class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
  end

  def confirm
    @user = User.find(params[:friendship_id])
    current_user.confirm_friend(@user)
    flash[:notice] = "You have accepted #{@user.name} request"
    redirect_to request.referrer
  end

  def reject
    byebug
    @user = User.find(params[:friendship_id])
    @friendship = current_user.find_friendship(@user)
    flash[:alert] = "You have rejected #{@user.name} request" if @friendship.destroy
    redirect_to request.referrer
  end

  def create
    @friendship = Friendship.new(friendship_params)

    redirect_to request.referrer, notice: "Request was successfully sent to #{@friendship.friend.name}" if @friendship.save
  end

  def destroy
    @user = User.find(params[:id])
    @friendship = current_user.find_friendship(@user)

    flash[:alert] = "You have unfriended #{@user.name}" if @friendship.destroy
    redirect_to request.referrer
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
