module UsersHelper
  def display_invitation(user: nil)
    return if user == current_user

    return 'You are friends' if current_user.friends.include?(user)

    unless current_user.check_request_existence(user)
      return link_to 'Send Friend Request', friendships_path(id: user.id), method: :post
    end

    recieved_friend_request = current_user.pending_friend_requests.where(user_id: user.id).first
    if recieved_friend_request
      return link_to 'Accept Friend Request', friendship_path(recieved_friend_request.id), method: :patch
    end

    sent_friend_requests = current_user.sent_friend_requests.where(friend_id: user.id).first
    'Request already sent' if sent_friend_requests
  end

  def display_pending_requests(user)
    render 'users/pending', locals: { user: user } if user == current_user
  end
end
