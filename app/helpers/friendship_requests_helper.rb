module FriendshipRequestsHelper
  def add_btn(user)
    return unless add_friend?(user)

    button_to 'Add Friend',
              user_friendship_requests_path(user.id),
              class: 'btn add-friend btn-secondary',
              type: 'submit', method: :post
  end

  def accept_btn(user)
    check_pending_request(user, 'Accept', :patch)
  end

  def reject_btn(user)
    check_pending_request(user, 'Reject', :delete)
  end

  def retrieve_user(user)
    @user = user
  end

  def check_pending_request(user, action, method)
    return unless pending_friend?(user)

    sent_request = Friendship.find_by(friend: user)
    button_to action,
              user_friendship_request_path(user.id, sent_request.id),
              method: method, class: 'btn add-friend btn-secondary', type: 'submit'
  end

  def logged_in_user
    @logged_in_user
  end

  def usr
    @user
  end

  def pending_friend_requests
    @pending_friend_requests
  end

  def sender_id(request)
    request.friend.id
  end

  def request_id request
    request.id
  end

  def sender_name request
    request.friend.name
  end
end
