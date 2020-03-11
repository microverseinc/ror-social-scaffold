class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def send_request
    friendship = Friendship.create(user_id: current_user.id,
                                   friend_id: params[:friend_id],
                                   status: false)
    redirect_to users_path, notice: 'Send your friend request successfully' if friendship.save
  end

  def accept
    accept = Friendship.find_by(id: params[:id])
    return unless accept

    accept.update(status: true)
    redirect_to requests_path, notice: 'You accepted request'
  end

  def decline
    decline = Friendship.find_by(id: params[:id])
    return unless decline

    decline.destroy
    redirect_to requests_path, notice: 'You decline request'
  end

  def show_requests
    @request = Friendship.where(friend_id: current_user.id, status: false)
  end
end
