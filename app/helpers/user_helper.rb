module UserHelper
  def confirmed_friend(user)
    friendship = friend(user)
    friendship.confirmed.count.positive? ? friendship.first : nil
  end

  def friend(user)
    @friends = current_user.friendships.where('friend_id = ?', user.id)
      .or(current_user.inverse_friendships.where('user_id = ?', user.id))

    if @friends.count.zero?
      link_to('Invite to friendship', friendships_path(friend_id: user),
              method: :post, class: 'btn btn-info w-25')
    end
  end
end
