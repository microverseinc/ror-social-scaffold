class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @friends = current_user.friends
    @pending_friends = current_user.pending_friends
    @friend_requests =  current_user.friend_requests
  end

  def invite
    @friendship = current_user.friendships.new(invitee_id: params[:id])

    unless already_invited?(params[:id])
      if @friendship.save
        redirect_to friends_path
      end
    else
      redirect_to users_path, alert: 'You already invited this User'
    end
  end

  def accept
    this_friendship = Friendship.where(inviter_id: params[:id], invitee_id: current_user.id)
    this_friendship.update(status: true)
    redirect_to friends_path
  end

  def reject
    this_friendship = Friendship.where(inviter_id: params[:id], invitee_id: current_user.id)
    this_friendship.delete_all
    redirect_to friends_path
  end

  private
  def already_invited?(user_id)
    if current_user.friendships.find_by(invitee_id: user_id, status: false)
      true
    else
      false
    end
  end

end
