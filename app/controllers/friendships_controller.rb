class FriendshipsControllerController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])

    if @friendship.save
      redirect_to _path, notice: 'You succesfully made friend request.'
    else
      redirect_to _path, alert: 'You cannot send friend request.'
    end
  end

  def destroy
    friendship = Friendship.find_by(id: params[:id], user: current_user, user_id: params[:user_id])
    if friendship
      friendship.destroy
      redirect_to _path, notice: 'You are no longer friends with this user.'
    else
      redirect_to _path, alert: 'You can delete the is friendship.'
    end
  end
end
