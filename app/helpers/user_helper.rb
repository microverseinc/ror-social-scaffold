module UserHelper
  def friendship_invitation(inviter: nil, invitee: nil)
    invitation = current_user.invitation.new.where(
      ['inviter_id = ? and invitee_id = ?', inviter, invitee]
    )
    if current_user
      link_to('Send friendship invitation',
                       invitations_create_path(inviter: inviter,
                                              invitee: invitee)
              )
    else
      render(users_path)
    end
  end
  
end
  