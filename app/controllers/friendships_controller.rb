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
    # @friendship.update(confirmed: true )
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed = true
    @friendship.save
    # debugger
    redirect_to my_friends_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.delete 
    # debugger
    redirect_to root_path
  end

private
def friendship_params
  params.require(:friendship).permit(:user_id, :friend_id)
end
end



