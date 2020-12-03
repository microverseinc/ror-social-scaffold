module UsersHelper
  def friendship_button(user)
    if current_user.friend_requests.include?(user)
      concat(list_group(user))
    elsif current_user.pending_friends.include?(user)
      concat(content_tag(:span, (link_to 'Confirm', user_path(user.id), method: 'post', class: 'btn btn-primary')))
      concat(content_tag(:span, (link_to 'Decline', user_friendship_path(current_user.id, friendship_id(user)),
                                         method: :delete, class: 'btn btn-danger')))
    elsif current_user == user
      concat(content_tag(:p))
    elsif !current_user.friend?(user)
      concat(content_tag(:span, (button_to 'Add friend', user_friendships_path(current_user.id),
                                           params: { friend_id: user.id.to_s })))
    end
  end

  def list_group(user)
    content_tag :div, class: 'list-group' do
      concat(content_tag(:span, (button_to 'Pending Request', user_friendships_path(current_user.id),
                                           params: { friend_id: user.id.to_s },
                                           class: 'list-group-item disabled', 'aria-disabled' => 'true')))
    end
  end
end
