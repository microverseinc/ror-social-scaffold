module UsersHelper
  def friendship_status(user)
    if current_user.friend_requests.map(&:user).include?(user)
      'You have a pending friend request from this user'
    elsif current_user.pending_friends.map(&:friend).include?(user)
      'You have already requested this user to be your friend'
    elsif current_user.my_self?(user)
      ''
    else
      'Friends'
    end
  end
end
