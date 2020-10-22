class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @users = User.all
    @friendship = current_user.friendships.new(friend_id: params[:friend_id], confirmed: false)
  end
end
