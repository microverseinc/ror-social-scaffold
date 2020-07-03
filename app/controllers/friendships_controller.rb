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
    @friendship = Friendship.find_by(user_id: params[:friendship_id])
    flash[:alert] = "You have rejected #{@friendship.user.name} request" if @friendship.destroy
    redirect_to request.referrer
  end

  def create
    @friendship = Friendship.new(friendship_params)

    return unless @friendship.save

    redirect_to request.referrer, notice: "Request was successfully sent to #{@friendship.friend.name}"
  end

  def destroy
    @user = User.find(params[:id])
    @friendship1 = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
    @friendship2 = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)

    flash[:alert] = "You have unfriended #{@user.name}" if @friendship1.destroy && @friendship2.destroy
    redirect_to request.referrer
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
