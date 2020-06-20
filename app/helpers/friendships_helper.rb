module FriendshipsHelper
  def friendship_status(friend_id)
    status = Friendship.where('(user_id = ? and friend_id = ?) OR (user_id = ? and friend_id = ?)',
                              current_user.id, friend_id, friend_id, current_user.id).first.status
    case status
    when nil
      'pending'
    when false
      'rejected'
    else
      'accepted'
    end
  end

  def sent_friend_request?(friend_id)
    sent = Friendship.where('(user_id = ? and friend_id = ?) OR (user_id = ? and friend_id = ?)',
                            current_user.id, friend_id, friend_id, current_user.id)
    return false if sent.empty?

    true
  end
end
