module PostHelper
  def show_post(user_id)
    post.user.confirmed_friendships.find_by(friend_id: current_user.id) or
    post.user.id == current_user.id or 
    current_user.confirmed_friendships.find_by(friend_id: post.user.id)
  end
end
