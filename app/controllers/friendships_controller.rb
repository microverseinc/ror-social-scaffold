class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build
    @friendship.friend_id = params[:id]

    if @friendship.save
      redirect_to users_path, notice: 'You send an invitation.'
    else
      redirect_to users_path, notice: 'You do not send an invitation.'
    end
  end

  def update
    @user = User.find(params[:id])
    current_user.confirm_friend(@user)
    redirect_to user_path(@user)
    flash[:notice] = 'You accept an Invitation'
  end

  def destroy
    @user = User.find(params[:id])
    current_user.reject_friend(@user)
    redirect_to user_path(@user)
    flash[:notice] = 'You reject an Invitation'
  end
end
