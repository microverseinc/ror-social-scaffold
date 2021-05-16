module FriendshipHelper
  def confirm_friendship_btn(inviter)
    button_to 'Confirm friendship',\
              confirm_invitation_path,\
              params: { invitation: { user_id: inviter.id, friend_id: current_user.id } }
  end

  def reject_friendship_btn(inviter)
    link_to 'Reject friendship', reject_invitation_path(inviter.id, 'friendship'), class: 'un-friend', method: :delete
  end
end
