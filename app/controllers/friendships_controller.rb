class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:notice] = 'Friendship request sent successfully'
    else
      flash[:notice] = 'Friendship request couldn\'t be sent'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id, :user_id)
  end
end
