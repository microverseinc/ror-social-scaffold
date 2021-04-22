module UserHelper
  def invite_to_friendship_btn(user)
    return if user == current_user or current_user.friend? user

    if current_user.pending_invitations.include? user
      content_tag :span, 'Pending request', class: 'pending_badge'
    else
      button_to 'Invite to friendship',\
                send_invitation_path,\
                params: { invitation: { inviter_id: current_user.id, invitee_id: user.id } }
    end
  end

  def cancel_friendship_btn(user)
    return unless current_user.friend? user

    link_to 'Undo friendship', reject_invitation_path(user), method: :delete, class: 'un-friend'
  end
end
