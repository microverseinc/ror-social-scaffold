module FriendshipRequestsHelper
  def add_btn(user)
    return unless add_friend?(user)

    button_to 'Add Friend',
              user_friendship_requests_path(user.id),
              class: 'btn add-friend btn-secondary',
              type: 'submit', method: :post
  end

  def accept_btn(user)
    check_pending_request(user, 'Accept')
  end

  def reject_btn(user)
    check_pending_request(user, 'Reject')
  end

  def retrieve_user(user)
    @user = user
  end

  def check_pending_request(user, action)
    return unless pending_friend?(user)

    sent_request = current_user.received_requests.find_by(sender_id: user.id)
    button_to action,
              user_friendship_request_path(user.id, sent_request.id),
              method: :patch, class: 'btn add-friend btn-secondary', type: 'submit'
  end
end
