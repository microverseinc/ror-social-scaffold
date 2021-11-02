class FriendshipsController < ApplicationController
  def index
    @invitations = current_user.friend_requests
  end

  def create
    invitation = Friendship.new(invitation_params)
    if invitation.save
      redirect_to users_path, notice: 'Invitation sent'
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  def update
    invitation = current_user.inverted_friendships.find_by(user_id: invitation_params[:user_id])
    if invitation.confirm_friend
      redirect_to invitations_path, notice: "#{invitation.user.name} is your friend now!"
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  def destroy
    if params[:status] == 'invitation'
      current_user.inverted_friendships.find_by(user_id: params[:id]).destroy
      redirect_to users_path, notice: 'Friendship canceled'
    elsif params[:status] == 'friendship'
      current_user.friendships.find_by(friend_id: params[:id]).destroy
      current_user.inverted_friendships.find_by(user_id: params[:id]).destroy
      redirect_to users_path, notice: 'Friendship canceled'
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:user_id, :friend_id)
  end
end
