class FriendshipInvitationsController < ApplicationController
  def index
    @invitations = current_user.friendship_requests
  end

  def create
    invitation = FriendshipInvitation.new(invitation_params)
    if invitation.save
      redirect_to users_path, notice: 'Invitation sent'
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  def update
    invitation = current_user.received_invitations.find_by(inviter_id: invitation_params[:inviter_id])
    invitation.confirmed = true
    if invitation.save
      redirect_to invitations_path, notice: "#{invitation.inviter.name} is your friend now!"
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  def destroy
    user = User.find(params[:id])
    invitation = current_user.friend_invitation user
    if invitation.destroy
      redirect_to users_path, notice: 'Friendship canceled'
    else
      flash.now.alert = 'Error'
      render users_path
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:inviter_id, :invitee_id)
  end
end
