module FriendshipsHelper
  def accept_friendship(user, friend)
    friendship = Friendship.find_by(user_id: user.id, friend_id: friend.id)
    friendship.update(status: true)
  end

  def destroy_friendship(user, friend)
    friendship = Friendship.find_by(user_id: user.id, friend_id: friend.id)
    friendship.destroy
  end
end
