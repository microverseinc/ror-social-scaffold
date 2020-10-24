class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friendships.all
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:id], confirmed: false)
    if @friendship.save
      redirect_to users_path, notice: 'You have sent a friendship request!'
    else
      redirect_to users_path, alert: 'Friendship request Sent already!'
    end
  end

  def destroy
    @friendship = current_user.confirmed_friendships.find_by(friend_id: params[:id])
    @friendship.destroy
    redirect_to users_path, notice: 'Friend has been removed'
  end
end
