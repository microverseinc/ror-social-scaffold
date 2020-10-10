module FriendshipsHelper
  def friendship_stack(user)
    if user == current_user
      content_tag(:span, '(Current User)', class: 'text-secondary text-bold')
    elsif current_user.friend? user
      link_to('Remove')
    elsif current_user.pending_friends.to_a.include? user
      content_tag(:span, 'Friend Request Sent', class: 'text-success')
    elsif current_user.friend_invites.to_a.include? user
      link_to('Accept', accept_request_path(invitor_id: user.id))
    else
      link_to('Send Invite', send_request_path(invitee_id: user.id), class: 'text-primary')
    end
  end
end
