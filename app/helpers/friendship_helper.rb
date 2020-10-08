module FriendshipHelper
  def display_add_friend(current_user, user)
    if current_user.friend?(user)
      content_tag(:td, (link_to 'Unfriend',  unfriend_path(user_id: current_user.id, friend_id: user.id)))
    else
      content_tag(:td, (link_to 'Add Friend', addfriend_path(confirmed: false, user_id: current_user.id, friend_id: user.id)))
    end
  end

  def display_approval_decline(current_user, friend)
    if current_user.friend?(user)
      content_tag(:td, (link_to 'Approve',  approve_friendship_path(user_id: current_user.id, friend_id: user.id)))
    else
      content_tag(:td, (link_to 'Decline', decline_friendship_path(confirmed: false, user_id: current_user.id, friend_id: user.id)))
    end
  end
end
