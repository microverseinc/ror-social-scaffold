class FriendshipsController < ApplicationController

  def send_request
    friendShip = Friendship.create(user_id:current_user.id,
                                  friend_id: params[:friend_id],
                                  status: false)
    if friendShip.save
      flash.now[:success] = "Send your friend request successfully"
      redirect_to users_path
    end
  end

  def accept
    accept = Friendship.find_by(id: params[:id])
    if accept
    accept.update(status: true)
    flash[:success] = "You accepted request"
    redirect_to requests_path
    end
  end
  def decline
    decline = Friendship.find_by(id: params[:id])
    if decline
      decline.destroy
      flash[:danger] = "You decline request"
      redirect_to requests_path
    end
  end
  def show_requests
    @request = Friendship.where(user_id:current_user.id,status: false)
  end

end