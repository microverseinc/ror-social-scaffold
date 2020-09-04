module FriendshipRequestsHelper
  def add_btn(user)
    if add_friend?(user)
      button_to 'Add Friend', user_friendship_requests_path(user.id), class: 'btn add-friend btn-secondary', type: 'submit', method: :post
    end
  end

  def accept_btn(user)
    if pending_friend?(user)
      sent_request = current_user.received_requests.find_by(sender_id: user.id)
      button_to 'Accept', user_friendship_request_path(user.id, sent_request.id), method: :patch, class: 'btn add-friend btn-secondary', type: 'submit'
    end
  end

  def reject_btn(user)
    if pending_friend?(user)
      sent_request = current_user.received_requests.find_by(sender_id: user.id)
      button_to 'Reject', user_friendship_request_path(user.id, sent_request.id), method: :delete, class: 'btn add-friend btn-secondary', type: 'submit'
    end
  end
end
