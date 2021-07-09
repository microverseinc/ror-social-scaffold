module InvitationsHelper


  def friendship_invitation(inviter: nil, invitee: nil)
    invitation = FriendshipInvitation.where(
      ['inviter_id = ? and invitee_id = ?', inviter, invitee]
    )
    if current_user
      link_to('Send friendship invitation',
                       invitations_create_path(inviter: inviter,
                                              invitee: invitee),
              class: 'friendship-invitation')
    else
      content_tag(:span, invitation.first.status.capitalize, class: 'friendship-invitation')
    end
  end

  
end
