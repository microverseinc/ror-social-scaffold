class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = 'Added Friend'
      redirect_to users_path
    else
      flash[:error] = 'Unable to Add Friend'
    end
  end
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = 'Successfully Removed Friend'
    redirect_to users_path
  end
end
