module FriendshipsHelper
  def new_request?(friend)
    request = Friendship.where(user_id: current_user.id, friend_id: friend, confirmed: false)
    request.empty?
  end

  def already_friends?(friend)
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend, confirmed: true)
    friendship.empty?
  end
end
