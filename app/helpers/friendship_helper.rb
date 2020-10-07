module FriendshipHelper
  def add_friend(current_user, user)
    if current_user.friend?(user)
      content_tag(:td, (link_to 'Unfriend', destroy_path(user_id: current_user.id, friend_id: user.id)))
    else
      content_tag(:td, (link_to 'Add Friend', addfriend_path(confirmed: false, user_id: current_user.id, friend_id: user.id)))
    end
  end
end
