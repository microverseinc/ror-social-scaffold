class FriendshipsController < ApplicationController

  def new; end

  def create
    # @user = User.find(params[:id])
    @friendship = current_user.friendships.build(received_friendship_id: params[:received_friendship_id]) 
    if @friendship.save
      redirect_to root_path,
      notice: 'Friend Request Sent'
    else
      redirect_to root_path,
      alert: 'Friend request not sent'
    end
  end

  def destroy; end
end
