module FriendshipsHelper
  def request_sent(user)
    current_user.requests_sent_unconfirmed.find_by(friend_id: user.id)
  end

  def request_recieved(user)
    current_user.requests_recieved_unconfirmed.find_by(user_id: user.id)
  end

  def new_request(user)
    current_user.requests_sent_unconfirmed.build(friend_id: user.id)
  end

  def friendship(user)
    request_sent = Friendship.find_by(user_id: current_user, friend_id: user.id)
    request_recieved = Friendship.find_by(user_id: user.id, friend_id: current_user.id)
    request_sent || request_recieved
  end
end
