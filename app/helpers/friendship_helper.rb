module FriendshipHelper
  def not_user_display(current_user, n_user)
    return unless n_user != current_user
    friendship = Friendship.find_by(user_id: n_user.id, friend_id: current_user.id)

    if current_user == n_user
      content_tag(:td, (link_to 'Unfriend', friendship_path(user_id: current_user.id, friend_id: n_user.id friendship_id: friendship.id)))
    elsif current_user.friend?(n_user)
      content_tag(:td, (link_to 'Unfriend', friendship_path(user_id: n_user.id, friend_id: current_user.id, friendship_id: friendship.id)))
    elsif n_user.friend_requests.include?(current_user) || n_user.pending_friends.include?(current_user)
      content_tag(:td, 'Pending')
    else
      content_tag(:td, (link_to 'Add Friend', friendships_path(confirmed: false, user_id: current_user.id,
                                                             friend_id: n_user.id,), method: :post))
    end
  end

  def user_display?(current_user, a_user)
    return unless a_user == current_user
    friendship = Friendship.find_by(user_id: a_user.id, friend_id: current_user.id)

    if current_user == a_user
      content_tag(:td, (link_to 'Unfriend', friendship_unfriend_path(user_id: current_user.id, friend_id: a_user.id, friendship_id: friendship.id)))
    elsif current_user.friend?(a_user)
      content_tag(:td, (link_to 'Unfriend', friendship_unfriend_path(user_id: current_user.id, friend_id: a_user.id, friendship_id: friendship.id)))
    else
      content_tag(:td, (link_to 'Add Friend', friendship_addfriend_path(confirmed: false, user_id: current_user.id,
                                                             friend_id: a_user.id, friendship_id: friendship.id)))
    end
  end

  def show_approve(user, p_friend)
    friendship = Friendship.find_by(user_id: p_friend.id, friend_id: user.id)
    link_to 'Approve', friendship_approve_friendship_path(user_id: user.id, friend_id: p_friend.id, friendship_id: friendship.id) if user == current_user
  end

  def show_decline(user, d_friend)
    friendship = Friendship.find_by(friend_id: user.id, user_id: d_friend.id)
    link_to 'Decline', friendship_unfriend_path(user_id: user.id, friend_id: d_friend.id, friendship_id: friendship.id) if user == current_user
  end
end
