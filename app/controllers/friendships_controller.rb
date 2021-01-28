class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    @friendship = Friendship.create(user_id: current_user.id, friend_id: friend.id)
    if @friendship.save
      redirect_to users_path, notice: 'Friend request sent.'
    else
      redirect_to root_path, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def update
    friendship = Friendship.find(params[:id])
    friendship.update!(confirmed: true)
    redirect_to user_path(friendship.user_id)
  end

  def destroy
    friendship = Friendship.find_by(friend_id: current_user.id)
    friendship.destroy
    flash[:danger] = 'Canceled Friend request!'
    redirect_to user_path(friendship.friend_id)
  end
end
