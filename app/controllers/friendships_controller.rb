class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])

    if @friendship.save
      redirect_to users_path, notice: 'Friend invitation send'
    else
      redirect_to users_path, alert: 'Something get wrong :( '
    end
  end

  def update
    friend = User.find(params[:user_id])
    current_user.confirm_friend(friend)
    redirect_to users_path, notice: 'Friend invitation accepted'
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friend = friendship.user
    current_user.reject_friend(friend)
    redirect_to users_path, alert: 'Invitation rejected'
  end
end
