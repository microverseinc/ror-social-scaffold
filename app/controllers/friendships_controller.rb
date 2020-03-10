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

end