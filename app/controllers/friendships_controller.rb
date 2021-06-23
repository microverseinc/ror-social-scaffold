class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new 
  end
  
  def create
    # @user = User.find(params[:friendship][:friend_id])
    # friend_user = User.find(params[:friendship][:friend_id])
    @friendship = current_user.friendships.build(friend_id: params[:friendship][:friend_id])
    if @friendship.save
      redirect_to users_path
    else
      redirect_to current_user
    end
  end

  def update
    @friendship.update(status: true )
  end

private
def friendship_params
  params.require(:friendship).permit(:user_id, :friend_id)
end
end



