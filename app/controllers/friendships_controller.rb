class FriendshipsController < ApplicationController
  def new
    # @friendship = Friendship.new
  end

  def create
    friend = User.find(params[:friend_id])
    friendship = current_user.friendships.build(friend_id: friend.id, confirmed: true)
    
    if friendship.save
      flash.now[:success] = "Invitation sent"
    end
      redirect_to friend
  end

end