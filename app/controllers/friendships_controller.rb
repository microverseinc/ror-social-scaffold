class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)

    redirect_to user_path if @friendship.save
  end

  private

  def friendship_params
    params.require(:friendship).permit(:confirmed, :user, :friend)
  end
end
