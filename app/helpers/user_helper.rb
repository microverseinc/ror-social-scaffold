module UserHelper
  def all_friends
    @inverse_friends = current_user.inverse_friendships.confirmed.map(&:user)
    @friends = current_user.friendships.confirmed.map(&:friend)

    (@inverse_friends + @friends).compact
  end

  def friend?(user)
    current_user.friendships.where('friend_id = ?', user.id) ||
      current_user.inverse_friendships.where('user_id = ?', user.id)
  end
end
