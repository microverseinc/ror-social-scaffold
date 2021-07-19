class FriendshipsController < ApplicationController
  def new
    @request = Friendship.new
    create
  end

  def create
    @request = Friendship.create(friendship_params)
    if @request.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id, :confirmed)
  end
end
