module UsersHelper

  def friends
    friends_array = friendships.map{|friendship| friendship.friend if friendship.status}
    friends_array + inverse_friendships.map{|friendship| friendship.user if friendship.status}
    friends_array.compact
  end


  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.status}.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.status}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.status = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end