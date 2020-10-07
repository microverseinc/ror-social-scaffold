class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create
    @friendship = current_user.friendships.create!(friendship_params)
    redirect_back(fallback_location: root_path)
    return unless @friendship.confirmed == true

    friend = Friendship.where(user_id: @friendship.friend_id)
    friend.find_by(friend_id: @friendship.user_id).update(confirmed: true)
  end

  def destroy
    friend = Friendship.find(params[:id])
    friend.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end

  def friendship_params
    params.require(:friendship).permit(:friend_id, :confirmed)
  end
end
