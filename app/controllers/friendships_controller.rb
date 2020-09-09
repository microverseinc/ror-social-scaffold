class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.request_friend(@user)
    redirect_to users_path(@user)
    flash[:notice] = 'Success'
  end

  def show
    redirect_to users_path
  end

  def update
    @user = User.find(params[:id])
    current_user.confirm_friend(@user)
    redirect_to users_path
    flash[:notice] = 'You have a new friend!'
  end

  def destroy
    @user = User.find(params[:id])
    current_user.delete_friend(@user)
    redirect_to users_path
    flash[:notice] = 'Friend deleted'
  end
end
