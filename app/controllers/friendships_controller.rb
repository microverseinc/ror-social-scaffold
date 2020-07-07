class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], confirmed: false)
    if @friendship.save
      flash[:notice] = 'Added Friend'
      redirect_to users_path
    else
      flash[:error] = 'Unable to Add Friend'
    end
  end

  def update
    @friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    @friendship.update(confirmed: true)
    @friendship.save
    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
    @friendship&.destroy
    @friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    @friendship&.destroy
    flash[:notice] = 'Successfully Removed Friend'
    redirect_to users_path
  end
end
