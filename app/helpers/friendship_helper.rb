module FriendshipHelper
  def display_add_friend(current_user, a_user)
    if current_user.friend?(a_user)
      content_tag(:td, (link_to 'Unfriend',  unfriend_path(user_id: current_user.id, friend_id: a_user.id)))
    else
      content_tag(:td, (link_to 'Add Friend', addfriend_path(confirmed: false, user_id: current_user.id, friend_id: a_user.id)))
    end
  end
=begin
  def display_approval_decline(d_user, friend)
    content_tag(:td, (link_to 'Approve',  approve_friendship_path(user_id: d_user.id, friend_id: friend.id)))
    content_tag(:td, (link_to 'Decline', decline_friendship_path(user_id: d_user.id, friend_id: friend.id)))
  end
=end
end
