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
    link = link_to('Invite to friendship', friendships_path(friend_id: user),
                   method: :post, class: 'btn btn-info w-25')
    link if friend(user).count.zero?
  end
end
