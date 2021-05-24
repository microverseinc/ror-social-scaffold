class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    invitee = User.find(params[:invitee_id])
    current_user.friendship_request(invitee) if invitee
    redirect_to user_path(params[:invitee_id])
  end

  def update
    current_user.accept_request(Friendship.find(params[:id]).inviter)
    redirect_to users_path
  end

  def destroy
    current_user.reject_request(Friendship.find(params[:id]).inviter)
    redirect_to users_path
  end
end
