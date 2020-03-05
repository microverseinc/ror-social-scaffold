class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      redirect_to users_path, notice: 'Friend Added.'
    else
      flash[:notice] = 'Unable to add friend.'
      redirect_to root_url
    end
  end
end
