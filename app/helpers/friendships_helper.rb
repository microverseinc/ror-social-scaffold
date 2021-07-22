module FriendshipsHelper
  def friendship_status(user)
    return if user == current_user

    if current_user.pending_friends.include?(user) || user.pending_friends.include?(current_user)
      render 'friendships/pending_friend_request', user: user
    elsif current_user.friends.include?(user) || user.friends.include?(current_user)
      render 'friendships/my_friends', user: user
    else
      render 'friendships/add_friend', user: user
    end
  end
end
