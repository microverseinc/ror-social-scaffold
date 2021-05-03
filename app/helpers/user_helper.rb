module UserHelper
  def friend_button(current_user, user)
    if current_user.friends.include?(user) || current_user.pending_friends.include?(user) || current_user.requested_friends.include?(user)
      ''
    else
      link_to 'Send Friend Request', add_friend_path(user), method: :post, class: 'btn btn-primary'
    end
  end
end
