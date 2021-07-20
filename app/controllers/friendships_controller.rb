class FriendshipsController < ApplicationController
  def new
    @request = Friendship.new
    create
  end

  def create
    @request = Friendship.create(friendship_params)
    if @request.save
      redirect_to root_path, notice: 'Friendship request sent!'
    else
      redirect_to users_path
    end
  end

  def edit
    update
  end

  def update
    @friendship = Friendship.where(accept_friend_params)
    if @friendship.update(friendship_params)
      redirect_to root_path, notice: 'You accepted the request!'
    else
      redirect_to root_path
    end
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id, :confirmed)
  end

  def accept_friend_params
    params.permit(:user_id, :friend_id, !:confirmed)
  end
end
