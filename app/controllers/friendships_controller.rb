class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    p "YEEEEEES:::>> #{params}"
    @friendship = Friendship.new(confirmed: params[:confirmed], user_id: params[:user_id], friend_id: params[:friend_id])
    p "YEEEEEES3333:::>> #{@friendship}"

    if @friendship.save
      redirect_to user_path, notice: 'Friend request was sent!!'
    else
      redirect_to user_path, notice: 'Unable to send friend request at this time.'
    end 
  end

  def destroy
    @friendship = Friendship.find(params[:friend_id, :user_id])
    p @friendship
    @friendship.destroy

    redirect_to user_path
  end
  private

  # def friendship_params
  #   params.require(:friendship).permit(:confirmed, :user_id, :friend_id)
  # end
end
