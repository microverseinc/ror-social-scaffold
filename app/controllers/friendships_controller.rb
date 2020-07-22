class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    @friendship.confirmed = 'Request'

    @inverse = Friendship.new
    @inverse.user_id = params[user_id]
    @inverse.friend_id = current_user.id
    @inverse.confirmed = 'Pending'

    if @friendship.save && @inverse.save
      redirect_to users_path, notice: 'Friend request successful'
    else
      redirect_to users_path, alert: 'Friend request not accepted'
    end
    
  end
end
