class FriendshipsController < ApplicationController
  def new

  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to users_path,
      notice: 'Sent Friend Request'
    else
      redirect_to users_path,
      alert: 'Friend Request Not Sent'
    end
  end
end
