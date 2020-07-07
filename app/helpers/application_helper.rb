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

  def see_profile(user)
    if current_user == (user)
       link_to 'See Profile',  user_path(user), class: 'profile-link' 
    end
  end

  def which_user(user)
    if current_user == (user)
      ''
    elsif current_user.friend?(user)
      link_to "Remove Friend", friendship_path(id: user.id), method: :delete, class: 'button3'
    elsif current_user.pending_friends.include?(user)
      link_to "Cancel Request", friendship_path(id: user.id), method: :delete, class: 'button3'
    elsif current_user.friend_requests.include?(user)
      link_to "Accept Request", friendship_path(id: user.id), method: :put, class: 'button2'
    else
      link_to 'Add Friend', friendships_path(friend_id: user), method: :post, class: 'button1'
    end
  end

  def friends
    current_user.friends + current_user.inverse_friends
  end

  def pending_friends
    current_user.pending_friends
  end

  def friend_requests
    current_user.friend_requests
  end
end


