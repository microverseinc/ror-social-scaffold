class FriendshipsController < ApplicationController
  include ApplicationHelper

  def create
    @user = User.find(params[:user_id])
    return if already_sended?(@user)
    return if sended_to_us?(@user)

    return if current_user == @user

    @friendship = current_user.pending_friendships.build(friend_id: params[:user_id], status: false)
    if @friendship.save
      redirect_to root_path
      flash[:notice] = 'Friend request sended'
    else
      flash[:notice] = 'somthing happened'
    end
  end
end
