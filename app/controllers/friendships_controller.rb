class FriendshipsController < ApplicationController
  def update
    # current_user.confirm_friend(User.find(params[:id]))
    redirect_to user_path(params[:id])
  end
end
