class FriendshipsController < ApplicationController
    
  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: 'pending')
  end

  def update
    Friendship.find(params[:id]).update(status: 'accepted')
  end


  def destroy
    Friendship.find(params[:id]).destroy
  end

  private

  def friendship_params
    params.require(:friendship).permit(:status)
  end

end

