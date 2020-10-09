module FriendshipHelper
  def display_add_friend(current_user, a_user)
    if current_user == a_user
      content_tag(:td, (link_to 'Unfriend', unfriend_path(user_id: current_user.id, friend_id: a_user.id)))
    elsif current_user.friend?(a_user)
      content_tag(:td, (link_to 'Unfriend', unfriend_path(user_id: current_user.id, friend_id: a_user.id)))
    else
      content_tag(:td, (link_to 'Add Friend', addfriend_path(confirmed: false, user_id: current_user.id,
                                                             friend_id: a_user.id)))
    end
  end
end
