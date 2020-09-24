class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: 'pending')
    if @friendship.save
      flash[:notice] = 'Added as a friend'
    else
      flash[:alert] = 'There was something wrong with the tracking request'
    end
    redirect_to root_path
  end

  def update
    Friendship.find(params[:id]).update(status: 'accepted')
    redirect_to root_path
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:status)
  end
end
