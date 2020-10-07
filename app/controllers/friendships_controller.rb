class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)

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

  def friendship_params
    params.require(:friendship).permit(:confirmed, :user_id, :friend_id)
  end
end
