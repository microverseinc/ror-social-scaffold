class FriendshipsController < ApplicationController
  def send_invitation
    if current_user.send_invitation(params[:user_id])
      flash.notice = 'Friend invitation sent'
      redirect_to users_path
    else
      flash.now[:notice] = 'error occured'
    end
  end

  def accept_invitation
    if current_user.confirm_invites(params[:user_id])
      flash.notice = 'friend accepted'
      redirect_to users_path
    else
      flash.now[:notice] = 'error occured'
    end
  end

  def reject_invitation
    current_user.reject_invites(params[:user_id])
    redirect_to users_path
  end

  def pending_invitation
    @pending_invitations = current_user.pending_invites
  end

  def destroy
    friend = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id)
    inverse_friend = Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id])
    friend&.delete
    inverse_friend&.delete
    redirect_to users_path
  end
end
