class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])

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
