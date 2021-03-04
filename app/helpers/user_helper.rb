module UserHelper
  def friend(user)
    current_user.friendships.where('friend_id = ?', user.id)
      .or(current_user.inverse_friendships.where('user_id = ?', user.id))
  end

  def confirmed_friend(user)
    friendship = friend(user)
    friendship.confirmed.count.positive? ? friendship.first : nil
  end

  def invite_friendship(user)
    if friend(user).count.zero?
      link_to('Invite to friendship', friendships_path(friend_id: user),
              method: :post, class: 'btn btn-info w-25')
    elsif friend(user).first.status == false
      link_to('Request Pending', user_path(user), class: 'btn btn-info w-25')
    end
  end
end
