module FriendshipsHelper
  def all_friendship_details(user)
    if current_user.id == user.id
      'friendships/friendships_details'
    else
      'layouts/empty'
    end
  end

  def invite_to_friendship(user)
    if current_user.id != user.id && friend(user).count.zero?
      'friendships/friendship_invite'
    else
      'layouts/empty'
    end
  end
end
