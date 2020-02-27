module UsersHelper
  def user_info(user)
    render partial: 'user_info', locals: { user: user } unless current_user?(user)
  end

  def friend_request(user)
    # rubocop:disable Style/GuardClause
    if current_user.friendship_created?(user) && !current_user?(user)
      render partial: 'friend_request', locals: { user: user }
    end
    # rubocop:enable Style/GuardClause
  end

  def current_user?(user)
    current_user == user
  end
end
