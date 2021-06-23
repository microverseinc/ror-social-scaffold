module UserHelper
  def friends?(user)
    Friendship.exists?(user_id: current_user.id, friend_id: user)
  end

  def sent_requests
    @requested_friends = []
    @sent_requests = Friendship.where('user_id = ? and status = ?', current_user.id, false)
    @sent_requests.each { |u| @requested_friends << User.find(u.friend_id) }
    @requested_friends
  end
end
