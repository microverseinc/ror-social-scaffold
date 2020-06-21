module FriendshipsHelper
  def verify_friendship(friend_id)
    status = Friendship.where('(user_id = ? and friend_id = ?) OR (user_id = ? and friend_id = ?)',
                              current_user.id, friend_id, friend_id, current_user.id).first
    status
  end
end
