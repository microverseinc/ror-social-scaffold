class FriendshipsController < ApplicationController
  before_action :set_user
  before_action :set_friendship, except: %i[create]

  def create
    current_user.request_friendship(@user)
    redirect_to @user
  end

  def cancel_friend_request
    @friendship.destroy
    flash[:notice] = 'You have canceled the friend request'
    redirect_to @user
  end

  def accept_friend_request
    @friendship.update(status: true)
    flash[:notice] = "You have accepted #{@user.name} as your friend!!!"
    redirect_to @user
  end

  def destroy
    @friendship.destroy
    flash[:notice] = "You have canceled #{@user.name} request to be your friend!"
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_friendship
    @friendship = Friendship.find_by(friend_id: params[:id], user_id: current_user.id)
  end
end
