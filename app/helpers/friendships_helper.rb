module FriendshipsHelper
  def new_request?(friend)
    request1 = Friendship.find_by(user_id: current_user.id, friend_id: friend, confirmed: false)
    request2 = Friendship.find_by(user_id: current_user.id, friend_id: friend, confirmed: false)
    result = request1.nil? && request2.nil?
  end

  def already_friends?(friend)
    friendship1 = Friendship.find_by(user_id: current_user.id, friend_id: friend, confirmed: true)
    friendship2 = Friendship.find_by(user_id: friend, friend_id: current_user.id, confirmed: true)
    result = friendship1.nil? && friendship2.nil?
  end

  def pending_requests?
    requests = Friendship.where(friend_id: current_user.id, confirmed: false)
    requests.empty?
  end
end
