
module FriendshipsHelper
  def check_status(user)
    if !current_user.pending_friends.include?(user) && !user.pending_friends.include?(current_user)
      false
    elsif current_user.pending_friends.include?(user) || user.pending_friends.include?(current_user)
      true
    end
  end

  def add_friend(user)
    unless !current_user.friend?(user) && user != current_user && check_status(user) == false && !user.friends.include?(current_user)
      return false
    end

    true
  end

  def cancel_friend(user)
    if check_status(user) == true && user != current_user && user1 = current_user.friendships.find_by(friend_id: user.id)
      form_for(user1,
               html: { method: :delete }) do |f|
        f.submit 'cancel', class: 'btn'
      end
    end
  end

  def accept_or_decline(user)
    return false unless current_user.friend_requests.include?(user) &&
                        user != current_user &&
                        !current_user.friends.include?(user) && check_status(user) == true &&
                        !user.friends.include?(current_user)

    true
  end
end
