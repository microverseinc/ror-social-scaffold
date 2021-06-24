class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friendship][:friend_id])
    if @friendship.save
      redirect_to root_path
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.confirmed = true
    @friendship.save
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
