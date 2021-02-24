module UserHelper
  def all_friends
    @inverse_friends = current_user.inverse_friendships.confirmed.map{ |friendship| friendship.user}
    @friends = current_user.friendships.confirmed.map{ |friendship| friendship.friend}

    (@inverse_friends + @friends).compact
  end

end