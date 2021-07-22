module FriendshipsHelper
  def friendship_status(user)
    return if user == current_user

    if current_user.pending_friends.include?(user) || user.pending_friends.include?(current_user)
      render 'friendships/pending_friend_request'
    elsif current_user.friends.where(id: user.id) || user.friends.where(id: current_user.id)
      render 'friendships/my_friends'
    else
      render 'friendships/add_friend', user: user
    end
  end
end
