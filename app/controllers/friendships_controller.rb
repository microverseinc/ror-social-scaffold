class FriendshipsController < ApplicationController
  include ApplicationHelper

  def create
    @user = User.find(params[:user_id])
    return if already_sended?(@user)

    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    if @friendship.save
      redirect_to root_path
      flash[:notice] = 'Friend request sended'
    else
      flash[:notice] = 'Friend request sended'
    end
  end



  def confirm
    @user = User.find(params[:user_id])
    @friendship = current_user.inverse_friendships.find { |friendship| friendship.user == user }
    @friendship.status = true
 
  end
end
