module UserHelper
  def invert_pending_friendship(id)
    @invers_pending.find_by(user_id: id)
  end

  def pending_friendship(id)
    @pending.find_by(friend_id: id)
  end

  def friends(id)
    true if @confirmed_friendship.find_by(friend_id: id) or @invert_confirmed_friendship.find_by(user_id: id)
  end

  def not_friends(id)
    true if current_user.friendships.find_by(friend_id: id) or current_user.inverse_friendships.find_by(user_id: id)
  end

  def status(id)
    res = {}
    unless not_friends(id)
      res[0] = link_to 'Add friend', add_friend_path(id: id)
    end 
    friendship = invert_pending_friendship(id)
    if friendship
      res[0] =result = link_to ' Accept ', accepts_friend_path(id: id) 
      res[1] =result1 = link_to ' Reject ', reject_friend_path(id: friendship.id)
    elsif  friends(id)
      res[0] ='Friends' 
    elsif  pending_friendship(id)
      res[0] ='Pending Friendship'
    end
    res
  end

end
