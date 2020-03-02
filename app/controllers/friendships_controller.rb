class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash.now = 'Added Friend'
# Need to render
    else
      flash.now = 'Unable to add friend.'
      redirect_to root_url
    end
  end
end
