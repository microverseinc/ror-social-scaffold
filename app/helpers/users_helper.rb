module UsersHelper
  def display_invitation(user: nil, friend: nil)

    if user.friends.include?(friend)
      return "You are friends"
    end

    unless user.check_request_existence(friend)
      return link_to 'Send Friend Request', friendships_path(user_id: user.id, friend_id: friend.id), method: :post
    end

    recieved_friend_request = user.pending_friend_requests.where(user_id: friend.id).first
    if recieved_friend_request
      return link_to 'Accept Friend Request', friendship_path(recieved_friend_request.id), method: :patch
    end

    sent_friend_requests = user.sent_friend_requests.where(friend_id: friend.id).first
    if sent_friend_requests
      return "Request already sent"
    end

  end
end
