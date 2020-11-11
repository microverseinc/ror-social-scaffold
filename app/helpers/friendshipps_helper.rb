module FriendshippsHelper
  def friend_request_sent?(user)
    current_user.pending_friends.include?(user)
  end

  def friend_request_received?(user)
    current_user.friend_requests.include?(user)
  end
end
