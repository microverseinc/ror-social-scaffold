class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship

  def create
    if @friendship.nil?
      @friend_request = Friendship.new(user_id: current_user.id, friend_id: params[:id])
      if @friend_request.save
        @friend_request.pending!
        flash[:notice] = 'Friend Request Sent!'
      else
        flash[:alert] = 'Something Went Wrong!'
      end
    else
      flash[:notice] = 'Sorry! there is already a friend request pending with this user!'
    end

    redirect_to users_path
  end

  def update
    @friend_request = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    redirect_to users_path @friend_request.confirmed!
    flash[:notice] = 'Friend Request Accepted!'
  end

  def destroy
    redirect_to users_path if @friendship.destroy
    flash[:alert] = 'Friend Request Rejected!'
  end

  private

  def set_friendship
    @friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id) ||
                  Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
  end
end
