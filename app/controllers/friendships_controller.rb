class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id], Acceptance: false)

    if @friendship.save
      redirect_to users_path, notice: 'Invite sent.'
    else
      redirect_to users_path, alert: 'Invitation failed, Try again later.'
    end
  end
end
