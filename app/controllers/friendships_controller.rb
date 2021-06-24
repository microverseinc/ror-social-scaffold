class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:friend_id])
    @add_friend = current_user.friendships.new(friend_id: user.id, status: false)
    if @add_friend.save
      redirect_to users_path, notice: 'Friend request sent.'
    else
      redirect_to users_path, alert: 'You friend request was not sent.'
    end
  end
end
