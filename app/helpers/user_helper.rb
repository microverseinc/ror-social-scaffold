module UserHelper
  def friend_button(current_user, user)
    if current_user.friends.include?(user) ||
       current_user.pending_friends.include?(user) || current_user.requested_friends.include?(user)
      ''
    else
      unless current_user.id == user.id
        link_to 'Send Friend Request', add_friend_path(user), method: :post,
                                                              class: 'btn btn-primary'
      end
    end
  end

  def friendship_table(my_friends, requested_friends, current_user, user)
    if current_user.id == user.id && my_friends.count.positive? || requested_friends.count.positive?
      render 'shared/myfriends'
    elsif current_user.id == user.id && !my_friends.count.positive? && !requested_friends.count.positive?
      content_tag :p, "You don't have any friends yet. make some friends.", style: 'align = center;', class: 'lead'

    else
      ''
    end
  end
end
