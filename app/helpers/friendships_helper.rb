module FriendshipsHelper

  def invitation_action_links(user)
    if current_user == user
      content_tag(:span, 'Your profile', class: 'profile-link')
    elsif current_user.friend?(user)
      content_tag(:span, 'Is your friend', class: 'profile-link')
    elsif current_user.friend_requests.include?(user)
      link_to('Accept invitation', friendship_path(user), method: :patch, class: 'profile-link') +
        content_tag(:span, ' | ') +
        link_to('Reject invitation', friendship_path(user), method: :delete, class: 'profile-link')
    elsif current_user.pending_friends.include?(user)
      content_tag(:span, 'You already sent an invitation', class: 'profile-link')
    else
      (link_to 'Send friendship invitation', friendships_path(receiving_user_id: user.id), method: :post, class: 'profile-link')
    end
  end
end
