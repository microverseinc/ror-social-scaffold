module UserHelper
  def invite_to_friendship_btn(user)
    return if user == current_user or current_user.friend? user

    if current_user.pending_invitations.include? user
      content_tag :span, 'Pending request', class: 'pending_badge'
    elsif current_user.invited_by? user
      render partial: 'shared/confirm_reject_btn', locals: { user: user }
    else
      button_to 'Invite to friendship',\
                send_invitation_path,\
                params: { invitation: { user_id: current_user.id, friend_id: user.id } }
    end
  end

  def cancel_friendship_btn(user)
    return unless current_user.friend? user

    link_to 'Undo friendship', reject_invitation_path(user), method: :delete, class: 'un-friend'
  end

  def reject_friendship_btn(user)
    link_to('Reject Friendship', reject_invitation_path(user), method: :delete, class: 'un-friend')
  end

  def confirm_friendship_btn(user)
    button_to('Confirm friendship',\
              confirm_invitation_path,\
              params: { invitation: { user_id: user.id, friend_id: current_user.id } })
  end
end
