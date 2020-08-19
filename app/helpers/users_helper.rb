module UsersHelper
  def render_friendships(user)
    if current_user.friend_invites(user)
      content_tag(:button, 'Pending Invitations', class: 'btn btn-sm btn-warning')
    elsif current_user.receive_invitation(user)
      link_to('Accept', accept_invite_path(user_id: user.id), class: 'btn btn-sm btn-primary')
      link_to('Decline', reject_invite_path(user_id: user.id), method: :delete, class: 'btn btn-sm btn-danger')
    elsif !current_user.friend?(user) && current_user.id != user.id
      link_to('Add Friend', send_invite_path(user_id: user.id), class: 'btn btn-sm btn-success')
    elsif current_user.friend?(user)
      link_to('Remove friend', remove_friend_path(user_id: user.id),
              method: :delete, data: { confirm: 'Are you sure you want to remove friend?' },
              class: 'btn btn-sm btn-danger')
    end
  end
end
