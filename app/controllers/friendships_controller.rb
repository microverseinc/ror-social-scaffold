class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id], status: false)

    if @friendship.save
      redirect_to users_path, notice: 'Friend Invite Sent.'
    else
      redirect_to users_path, alert: 'Invite Not Sent'
    end
  end
end
