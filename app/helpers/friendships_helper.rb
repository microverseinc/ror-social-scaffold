module FriendshipsHelper
  def check_status(user)
    if !current_user.pending_friends.include?(user) && !user.pending_friends.include?(current_user)
      false
    elsif current_user.pending_friends.include?(user) || user.pending_friends.include?(current_user)
      true
    end
  end

end
