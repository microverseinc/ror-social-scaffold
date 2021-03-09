module FriendshipHelper
  def make_request(user)
    return 'Waiting for response' if current_user.pending_friends.exists?(user)

    return 'You are friends' if current_user.friends.exists?(user)

    can_request(user) unless current_user.pending_friends.exists?(user) || current_user.id == user
  end

  def can_request(user)
    return if current_user.friend_requests.exists?(user)

    link_to 'Request Friendship',
            friendships_path(requestor_id: current_user.id, requested_id: user),
            method: :create,
            class: 'friend'
  end

  def accept_request(user)
    return unless current_user.friend_requests.exists?(user)

    friendship = Friendship.find_by(requestor_id: user, requested_id: current_user.id)
    link_to 'Accept request',
            friendship_path(id: friendship.id, requested_id: user),
            method: :patch,
            class: 'friend'
  end

  def cancel_request(user)
    return unless current_user.friend_requests.exists?(user)

    friendship = Friendship.find_by(requestor_id: user, requested_id: current_user.id)
    link_to 'Reject request',
            friendship_path(id: friendship.id),
            method: :delete,
            class: 'btn-danger'
  end
end
