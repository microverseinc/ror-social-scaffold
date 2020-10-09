module FriendshipHelper
  def not_user_display(current_user, n_user)
    return unless n_user != current_user

    if current_user == n_user
      content_tag(:td, (link_to 'Unfriend', unfriend_path(user_id: current_user.id, friend_id: n_user.id)))
    elsif current_user.friend?(n_user)
      content_tag(:td, (link_to 'Unfriend', unfriend_path(user_id: current_user.id, friend_id: n_user.id)))
    else
      content_tag(:td, (link_to 'Add Friend', addfriend_path(confirmed: false, user_id: current_user.id,
                                                             friend_id: n_user.id)))
    end
  end

  def user_display?(current_user, a_user)
    return unless a_user == current_user

    if current_user == a_user
      content_tag(:td, (link_to 'Unfriend', unfriend_path(user_id: current_user.id, friend_id: a_user.id)))
    elsif current_user.friend?(a_user)
      content_tag(:td, (link_to 'Unfriend', unfriend_path(user_id: current_user.id, friend_id: a_user.id)))
    else
      content_tag(:td, (link_to 'Add Friend', addfriend_path(confirmed: false, user_id: current_user.id,
                                                             friend_id: a_user.id)))
    end
  end

  def show_approve(user, p_friend)
    link_to 'Approve', approve_friendship_path(user_id: user.id, friend_id: p_friend.id) if user == current_user
  end

  def show_decline(user, d_friend)
    link_to 'Decline', decline_friendship_path(user_id: user.id, friend_id: d_friend.id) if user == current_user
  end
end
