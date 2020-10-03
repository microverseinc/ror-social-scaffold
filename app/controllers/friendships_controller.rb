class FriendshipsController < ApplicationController

  def create
    @friendship=current_user.friendships.create!(friendship_params)
  end

  def destroy
    friend=Friendship.find(params[:id])
    friend.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Friendship was ended.' }
      format.json { head :no_content }
    end
    
  end  
  

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end  
end