module UserHelper
  def render_friendship(user)
    return if current_user == user
    friendship_param = { friendship: { user_id: current_user, friend_id: user, status: false } }
    delete_param = { id: user.id }

    unless current_user.friend?(user) && unless current_user.already_friend?(user)
    link_to: "Send Friend Request", friendships_path(friendship_param),
    method: :post
    
    unless current_user.already_friend?(user)
      link_to: "Remove Friend", friendship_path(delete_param)
      method: :delete
    
    unless !current_user.already_friend?(user)
      link = capture do 
        link_to: 'Delete Request', friendships_path(delete_param)
        method: :delete
      end
      link << capture {link_to: 'Request pending' friendships_path(current_user)}
  end
  end
end

def render_request_btn(user); end