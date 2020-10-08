class FriendshipsController < ApplicationController

  def new
    @friendship = Friendship.new
  end

  def create
    p "YEEEEEES:::>> #{params}"
    @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id])
    # @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      render @friendship.user, notice: 'Friend request was sent!!'
    else
      redirect_to user_path, notice: 'Unable to send friend request at this time.'
    end
  end

  def destroy
    # @user = User.find(params[:friend_id])
    # @friendship = @user.friendships.where(friend_id: params[:user_id])
    # p "NoNoNo:::>>>>#{@friendship.length}<<<<<"
    # @friendship.destroy_all


    @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    if @friendship == nil
      @friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: params[:user_id])
    end
    @friendship.destroy

    redirect_to user_path(params[:user_id])
  end

  def approve
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    @user.confirm_friend(@friend)

    redirect_to user_path(params[:user_id])
  end

  private

  # def friendship_params
  #   params.require(:friendship).permit(:confirmed, :user_id, :friend_id)
  # end
end
