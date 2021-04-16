module UsersHelper
  def request_sent(user)
    @user = user
    current_user.sent_requests.any? do |request|
      request.friend_id == @user.id
    end
  end

  def request_received(user)
    @user = user
    current_user.received_requests.any? do |request|
      request.user_id == @user.id
    end
  end

  def check_friendship_status(user, friend)
    user = Friendship.where(user_id: user, friend_id: friend)
    status = user.pluck(:status)
    status[0]
  end
end
