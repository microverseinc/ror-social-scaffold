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

  def friendship_request_button(friend)
    return unless signed_in?
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: friend.id)
    if friendship && friendship.status == true
      remove_friend
    elsif friendship && friendship.status != true
      if friendship.friend_id == current_user.id
        accept_request
      else
        cancel_request
      end
    elsif !friendship
      inverse_check(friend)
    end
  end

  def inverse_check(friend)
    friendship = Friendship.find_by(user_id: friend.id, friend_id: current_user.id)
    if friendship && friendship.status == true
      remove_friend
    elsif friendship && friendship.status != true
      if friendship.friend_id == current_user.id
        accept_request
      else
        cancel_request
      end
    elsif current_user.id != friend.id
      add_friend
    end
  end

  def accept_request
    #Accepts invitations
    "<p>Accept</p>".html_safe
  end

  def cancel_request
    #Cancel invitations request
    "<p>Pending</p>".html_safe
  end

  def add_friend
    #Add a friend
    "<p>Add Friend</p>".html_safe
  end

  def remove_friend
    #Remove a friend
    "<p>You are Friends</p>".html_safe
  end
end
