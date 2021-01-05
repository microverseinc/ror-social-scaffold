module UsersHelper
  def current_user?(user)
    current_user == user
  end

  def friendship_requested?(user)
    Friendship.where(user_id: id, friend_id: user.id, confirmed: nil)
  end

  def friend_or_friendship_requested(user, current_user)
    unless current_user.friendship_requested?(user) || current_user.friend?(user) || user.friendship_requested?(current_user)
      link_to 'Add Friend', friendships_path(user_id: user.id), method: :post
    end
  end

  def friend_status(user, current_user)
    if user.friendship_requested?(current_user)
      raw("<a> &nbsp &nbsp Accept Friend Request:</a>
          <span class='profile-link'>
            #{link_to 'Accept', friendship_path(request), method: :patch, class: 'profile-link'} |
            #{link_to 'Reject', friendship_path(request), method: :delete, data: { confirm: 'Are you sure?' }, class: 'profile-link'}
          </span>")
    elsif current_user.friendship_requested?(user)
      raw("Wait for #{user.name} to accept your friend request!")
    end
  end
end
