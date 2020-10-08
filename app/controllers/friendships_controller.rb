class FriendshipsController < ApplicationController

  def new
    @friendship = Friendship.new
  end

  def create
    p "YEEEEEES:::>> #{params}"
    @friendship = Friendship.new(confirmed: params[:confirmed], user_id: params[:user_id], friend_id: params[:friend_id])
    p "YEEEEEES3333:::>> #{@friendship}"

    if @friendship.save
      render @friendship.user, notice: 'Friend request was sent!!'
    else
      redirect_to user_path, notice: 'Unable to send friend request at this time.'
    end 
  end

  def destroy
    @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    @friendship.destroy

    redirect_to user_path(params[:user_id])
  end

  def approve
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])

    @friend.confirm_friend(@user)
  end

  private

  # def friendship_params
  #   params.require(:friendship).permit(:confirmed, :user_id, :friend_id)
  # end
end
