module UserHelper
  def all_friends
    @inverse_friends = current_user.inverse_friendships.confirmed.map(&:user)
    @friends = current_user.friendships.confirmed.map(&:friend)

    (@inverse_friends + @friends).compact
  end

  def friend(user)
    current_user.friendships.where('friend_id = ?', user.id)
      .or(current_user.inverse_friendships.where('user_id = ?', user.id))
  end

  def confirmed_friend(user)
    friendship = friend(user)
    friendship.confirmed.count.positive? ? friendship.first : nil
  end

  def friend_post(post)
    if post.user == current_user || confirmed_friend(post.user)
      'posts/post'
    else
      'layouts/empty'
    end
  end
end
