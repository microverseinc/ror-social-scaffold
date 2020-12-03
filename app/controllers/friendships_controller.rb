class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    @friendship = Friendship.new(user_id:current_user,friend_id:friend)
    @friendship.save
    flash[:success] = 'Friendrequest sent'
    redirect_to user_path(current_user)
  end

  def update
    
  end

  def destroy
  end

  private

  def friendship_params
    params.require(:friendships).permit(:user_id, :friend_id)
  end

end
