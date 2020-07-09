class FriendshipsController < ApplicationController
  before_action :set_friendship, only: :destroy
  def create
    @friendship = Friendship.create(friendship_params)
    @friendship.save
    redirect_to request.referrer
  end

  def destroy
    @friendship.destroy
    redirect_to request.referrer
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id, :confirmed)
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

end
