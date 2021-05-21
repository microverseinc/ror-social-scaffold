module UsersHelper

  def requested_user(user)
    current_user.users_requested.include?(user)
  end
end
