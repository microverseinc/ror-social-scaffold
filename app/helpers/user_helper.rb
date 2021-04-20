module UserHelper
  # def current_user_friends
  #   friend_list = current_user.friendships.map { |f| f.friend_id if f.status == 1 }
  #   friend_list += current_user.inverse_friendships.map { |f| f.user_id if f.status == 1 }
  #   friend_list += [current_user.id]
  #   friend_list
  # end

  # def requested_and_received
  #   friend_list = current_user.inverse_friendships.map { |f| f.friend_id }
  #   friend_list += current_user.friendships.map { |f| f.user_id }
  # end

  def all_users
    User.select{ |u| u.id != current_user.id}
  end
end
