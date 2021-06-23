class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new 
  end
  
  def create
    # @user = User.find(params[:friendship][:friend_id])
    # friend_user = User.find(params[:friendship][:friend_id])
    @friendship = current_user.friendships.build(friend_id: params[:friendship][:friend_id])
    
    if @friendship.save
      flash.now[:success]= "Friend request sent!"
    else
      flash.now[:danger]= "Friend request not sent, unluckly!"
    end
    redirect_to root_path
  end

  def update
    @friendship.update(status: true )
  end

private
def friendship_params
  params.require(:friendship).permit(:user_id, :friend_id)
end
end



