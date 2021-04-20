class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)
    flash[:notice] = @friendship.save ? 'Friendship request sent' : 'Fail. Try Again'
    redirect_back(fallback_location: root_path)
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed!
    flash[:notice] = 'Friendship accepted'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Friendship.find(params[:id]).destroy
    flash[:notice] = 'Unfriended successfully'
    redirect_back(fallback_location: root_path)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :id)
  end
end
