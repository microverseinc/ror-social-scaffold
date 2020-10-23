class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    # byebug
    @users = User.all
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], confirmed: false)

    if @friendship.save
      redirect_to user_path(id: params[:friend_id]), notice: 'Friend request sent.'
    else
      redirect_to users_path, error: 'Request not sent. Something is wrong!'
    end
  end
end
