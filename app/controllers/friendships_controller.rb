class FriendshipsController < ApplicationController
  def create
    Friendship.request(@user1, @friend)
    flash[:notice] = "Friend request has been sent to #{user.name}."
    redirect_to users_path(@friend)
  end

  private

  def user
    @user1 = current_user
    @friend = User.find(params[:user_id])
  end
end
