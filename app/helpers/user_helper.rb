module UserHelper
  def render_friendship(user)
    return if current_user == user
    delete_param = { id: user.id }

    if !current_user.friend?(user) && !current_user.already_friend?(user)
    link_to "Send Friend Request", friendships_path(user_id: current_user, friend_id: user.id, confirmed: false),
    method: :post
    
    elsif !current_user.already_friend?(user)
      link_to "Remove Friend", friendship_path(delete_param),
      method: :delete
    
    elsif current_user.already_friend?(user)
      link = capture do 
        link_to 'Delete Request', friendships_path(delete_param),
        method: :delete
      end
      link << capture {link_to 'Request pending', friendships_path(current_user)}
  end
  end
 
end

def render_request(user); end