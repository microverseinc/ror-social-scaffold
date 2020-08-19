class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
    @pending_friends = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def invite
    @friendship = current_user.friendships.new(invitee_id: params[:id])

    if already_invited?(params[:id])
      redirect_to users_path, alert: 'You already invited this User'
    elsif @friendship.save
      redirect_to friends_path
    end
  end

  def accept
    redirect_to friends_path if current_user.accept_friend(params[:id])
  end

  def reject
    this_friendship = Friendship.where(inviter_id: params[:id], invitee_id: current_user.id)
    this_friendship.delete_all
    redirect_to friends_path
  end
end
