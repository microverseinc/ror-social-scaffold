module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end
  def friend_request_sent?(user)
    current_user.friend_sent.exists?(friend_id: user.id, status: false)
  end
  
  def friend_request_received?(user)
    current_user.friend_request.exists?(user_id: user.id, status: false)
  end
  
  def possible_friend?(user)
    request_sent = current_user.friend_sent.exists?(friend_id: user.id)
    request_received = current_user.friend_request.exists?(user_id: user.id)
    
    return true if request_sent != request_recieved    
    return true if request_sent == request_recieved && request_sent == true    
    return false if request_sent == request_recieved && request_sent == false
  end
end
