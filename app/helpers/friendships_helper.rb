module FriendshipsHelper

  def request_sent(user)
    current_user.requests_sent_unconfirmed.find_by(friend_id:user.id)
  end

end
