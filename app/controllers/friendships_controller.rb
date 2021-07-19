class FriendshipsController < ApplicationController
  def new
    @request = Friendship.new
    create
  end

  def create
    @request = Friendship.create(friendship_params)
    if @request.save
    end
    redirect_to root_path
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id, :confirmed)
  end
end
