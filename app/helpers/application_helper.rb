module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def friendship_status(user)
    if current_user == user
        "This is you !!" 
    elsif current_user.friend?(user)  
        "It's your friend ".html_safe +
        (link_to "Remove", remove_friends_path(user_id: user.id), class: "btn btn-danger", data: { confirm: "You sure?" })
    elsif current_user.pending_friends.include?(user)  
          "Friend request already sent"
    elsif current_user.friend_requests.include?(user)  
        "You have a friend request from this user" 
    else 
        button_to "Add friend", friendships_path(friend_id: user.id), class:"btn btn-primary" 
    end 
  end

  def btn_link_profile(user)
    if current_user == user
      link_to 'your profile',  user_path(user), class: 'profile-link'
    else
      link_to 'See Profile',  user_path(user), class: 'profile-link'
    end
  end

  def btn_to_remove(item, user, str)
    if current_user == user
      link_to "#{str}", remove_friends_path(user_id: item.id), class: "btn btn-danger ml-3", data: { confirm: "You sure?" }
    end
  end

  def btn_to_accept(item, user, str)
    if current_user == user
      link_to "#{str}", update_friends_path(user_id: item.id), class: "btn btn-success ml-3"
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
end
