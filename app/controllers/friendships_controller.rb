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
    @user = User.find(@friendship.user_id)
    redirect_to @user
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.delete 
    redirect_to 'requests'
  end

private
def friendship_params
  params.require(:friendship).permit(:user_id, :friend_id)
end
end



