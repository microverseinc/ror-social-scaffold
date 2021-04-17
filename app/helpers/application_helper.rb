module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def friendship_status(receiver)
    requester = User.find(current_user.id)
    if requester == receiver
        "This is you !!" 
    elsif requester.friend?(receiver)  
        link_to "Remove", remove_friends_path(id: receiver.id), class: "btn btn-danger", data: { confirm: "You sure?" }
    elsif requester.pending_friends.include?(receiver)  
          "Friend request already sent"
    elsif requester.friend_requests.include?(receiver)  
        "You have a friend request from this user" 
    else 
        button_to "Add friend", friendships_path(receiver_id: receiver.id, requester_id: requester.id), class:"btn btn-primary"
    end 
  end

  def btn_link_profile(user)
    if current_user == user
      link_to 'your profile',  user_path(user), class: 'profile-link'
    else
      link_to 'See Profile',  user_path(user), class: 'profile-link'
    end
  end

  def btn_to_remove(user_to_remove, user_asking, str)
    if current_user == user_asking
      link_to "#{str}", remove_friends_path(id: user_to_remove.id), class: "btn btn-danger ml-3", data: { confirm: "You sure?" }
    end
  end

  def btn_to_accept(user_to_accept, user, str)
    if current_user == user
      link_to "#{str}", update_friends_path(user_id: user_to_accept.id), class: "btn btn-success ml-3"
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
