module UsersHelper
  def requested_user?(user)
    current_user.users_requested_ids.include?(user.id)
  end

  def requesting_user?(user)
    current_user.users_requesting_ids.include?(user.id)
  end

  def relationship(user)
    Relationship.find_by(user_id: user.id,friend_id:current_user.id) 
    ||
    Relationship.find_by(friend_id:current_user.id,friend_id:user.id)
  end
end
