module FriendshipsHelper
  def friends
    friend_id = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    user_id = Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friend_id + user_id
    User.where(id: ids)
  end
end
