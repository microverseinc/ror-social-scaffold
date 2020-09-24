module FriendshipsHelper
  def pending_friend_requests(user)
    Friendship.where(status: 'pending', friend_id: user.id)
  end
end
