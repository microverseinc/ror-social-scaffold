module UsersHelper
  def display_invitation(user: nil)

    if current_user.friends.include?(user)
      return "You are friends"
    end

    unless current_user.check_request_existence(user)
      return link_to 'Send Friend Request', friendships_path(id: user.id), method: :post
    end

    recieved_friend_request = current_user.pending_friend_requests.where(user_id: user.id).first
    if recieved_friend_request
      return link_to 'Accept Friend Request', friendship_path(recieved_friend_request.id), method: :patch
    end

    sent_friend_requests = current_user.sent_friend_requests.where(friend_id: user.id).first
    if sent_friend_requests
      return "Request already sent"
    end

  end
end
