class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friend_requests = Friendship.where(friend_id: current_user.id)
  end

  def create
    @friend = User.find_by(id: params[:friendships][:friend])
    return redirect_to root_path if current_user.cannot_add?(@friend)

    current_user.friendships.create(friend_id: @friend.id)
    redirect_to request.referrer
  end

  def update
    @friendship = Friendship.find(params[:id])
    if params[:requests][:status] == 'true'
      @friendship.accept
      current_user.friendships.create(friend_id: @friendship.user_id, confirmed: true)
    else
      @friendship.destroy
    end
    redirect_to request.referrer
  end
end
