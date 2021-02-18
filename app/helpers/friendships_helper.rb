# rubocop:disable Style/GuardClause
module FriendshipsHelper
  def friendship_exist?(user, friend)
    poss_one = Friendship.exists?(requestor_id: user, requested_id: friend)
    poss_two = Friendship.exists?(requestor_id: friend, requested_id: user)
    poss_one || poss_two ? true : false
  end

  def friendship(user, friend)
    if Friendship.exists?(requestor_id: user, requested_id: friend)
      Friendship.where(requestor_id: user, requested_id: friend).first
    else
      Friendship.where(requestor_id: friend, requested_id: user).first
    end
  end

  def status?(user, friend)
    poss_one = Friendship.exists?(requestor_id: user, requested_id: friend, status: true)
    poss_two = Friendship.exists?(requestor_id: friend, requested_id: user, status: true)
    poss_one || poss_two ? true : false
  end

  def requestor?
    Friendship.exists?(requestor_id: current_user.id)
  end

  def different_user(current, user)
    render partial: 'friend', locals: { friend: user } unless current == user
  end

  def make_request(current, user)
    if current != user
      if !status?(current, user) && requestor?
        'Waiting for response'
      elsif status?(current, user) && friendship_exist?(current, user)
        'You are friends'
      elsif !friendship_exist?(current, user)
        link_to 'Request Friendship',
                friendships_path(requestor_id: current, requested_id: user),
                method: :create,
                class: 'friend'
      end
    end
  end

  def accept_request(current, user)
    if !requestor? && friendship_exist?(current, user)
      link_to 'Accept request',
              friendship_path(id: friendship(user, current).id, requested_id: user),
              method: :patch,
              class: 'friend'
    end
  end

  def cancel_request(current, user)
    if !requestor? && friendship_exist?(current, user)
      link_to 'Reject request',
              friendship_path(id: friendship(user, current).id),
              method: :delete,
              class: 'btn-danger'
    end
  end
end
# rubocop:enable Style/GuardClause
