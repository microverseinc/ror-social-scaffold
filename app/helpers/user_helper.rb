module UserHelper
  def all_friends
    @inverse_friends = current_user.inverse_friendships.confirmed.map(&:user)
    @friends = current_user.friendships.confirmed.map(&:friend)

    (@inverse_friends + @friends).compact
  end

  def friendship_list(user)
    # check if user id is included on current user friendship list
    @current_user_list = current_user.friendships.where('friend_id = ?', user.id).count
  end

  def friend?(user)
    friendship = Friendship.find_by(friend: current_user, user: user) || 
    Friendship.find_by(friend: user, user: current_user)
    friendship ? true : false
  end
  
end