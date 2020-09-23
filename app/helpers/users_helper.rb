module UsersHelper
  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.status }
    friends_array.concat(inverse_friendships.map { |friendship| friendship.user if friendship.status })
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  def confirm_friend(user)
    friendship_var = inverse_friendships.find { |friendship| friendship.user == user }
    friendship_var.status = true
    friendship_var.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
