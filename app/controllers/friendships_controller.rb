class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.status = FALSE

    if @friendship.save
      redirect_to users_path, notice: 'You requested to be friends!'
    else
      redirect_to users_path, alert: 'You cannot add this user.'
    end
  end

  def accept
    friendship = Friendship.find(params[:friendship_id])
    friendship.status = TRUE
    if friendship.save
      redirect_to users_path, notice: 'You are now friends!'
    else
      redirect_to users_path, notice: 'You cannot be friends!'
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])
    return unless friendship
    friendship.destroy
    redirect_to users_path, notice: 'You removed a friend!'
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
