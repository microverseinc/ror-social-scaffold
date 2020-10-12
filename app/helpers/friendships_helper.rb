module FriendshipsHelper
  def friendship_stack(user)
    if current_user.friend? user
      link_to('Cancel friend', cancel_friend_path(user_id: user.id),
              method: :delete,
              data: { confirm: "Continue and cancel #{user.name}?" })
    elsif current_user.pending_friends.to_a.include? user
      content_tag(:span, 'Friend Request Sent', class: 'text-success text-bold')
    elsif current_user.friend_invites.to_a.include? user
      content_tag :span do
        content_tag(:span, link_to('Accept', accept_request_path(invitor_id: user.id), class: 'accept-link')) +
          content_tag(:span, link_to('Reject',
                                     decline_request_path(invitor_id: user.id),
                                     method: :delete,
                                     class: 'decline-link'))
      end
    else
      link_to('Send Invite', send_request_path(invitee_id: user.id), class: 'invite-link')
    end
  end
end
