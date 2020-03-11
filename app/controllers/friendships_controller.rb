class FriendshipsController < ApplicationController

  def send_request
    friendShip = Friendship.create(user_id:current_user.id,
                                  friend_id: params[:friend_id],
                                  status: false)
    if friendShip.save
      redirect_to users_path, notice: 'Send your friend request successfully'
    end
  end

  def accept
    accept = Friendship.find_by(id: params[:id])
    if accept
    accept.update(status: true)
    redirect_to requests_path , notice: 'You accepted request'
    end
  end

  def decline
    decline = Friendship.find_by(id: params[:id])
    if decline
      decline.destroy
      redirect_to requests_path, notice: 'You decline request'
    end
  end

  def show_requests
    @request = Friendship.where(friend_id:current_user.id,status: false)
  end

end