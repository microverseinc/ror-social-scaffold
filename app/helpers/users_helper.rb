module UsersHelper
  def check_user(user)
    (current_user != user)
  end

  def check_profile(user)
    current_user != user && !current_user.friendships.where(friend_id: user.id).exists?
  end

  def check_post(post)
    (current_user.friend.include?(post.user) || current_user == post.user)
  end
end
