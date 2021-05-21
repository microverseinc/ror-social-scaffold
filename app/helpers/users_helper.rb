module UsersHelper
  def requested_user?(user)
    current_user.users_requested_ids.include?(user.id)
  end

  def requesting_user?(user)
    current_user.users_requesting_ids.include?(user.id)
  end
end
