class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new
    @friendship.user_id = params[:user_id]
    @friendship.friend_id = params[:friend_id]
    @friendship.status = false
    if @friendship.save
      flash[:notice] = 'Friendship request sent successfully'
    else
      flash[:notice] = 'Friendship couldn\'t be sent'
    end
    redirect_to users_path
  end
end
