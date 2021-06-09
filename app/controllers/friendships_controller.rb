class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:id])

    if @friendship.save
      redirect_to users_path, notice: 'You succesfully made friend request.'
    else
      redirect_to users_path, alert: 'You cannot send friend request.'
    end
  end

  def update
    @friendship = Friendship.where(friend_id: [current_user, params[:id]], user_id: [current_user, params[:id]]).first
    @friendship.update(confirmed: true)
    if @friendship.save
      redirect_to users_path, notice: "Friend request accepted."
    else
      redirect_to users_path, alert: "Unable to accept friend request."
    end
  end

  
  def destroy
    @friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendship.destroy
    flash[:notice] = "Friend request declined."
    redirect_to users_path
  end

  
end
