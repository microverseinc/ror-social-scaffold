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
    if friendship
      if friendship.status == true
        # rubocop:disable Metrics/LineLength
        #(link_to 'Add Friend!', remove_attendances_path(id: event.id), method: :post).to_s.html_safe
        "<p>You are Friends</p>".html_safe
        #Create remove friend link
      else
        #(link_to 'Unfriend!', join_attendances_path(id: event.id), method: :delete).to_s.html_safe
        # rubocop:enable Metrics/LineLength
        if friendship.friend_id == current_user.id
          "<p>Accept</p>".html_safe
          #Create link to accept invitation
        else
          "<p>Pending</p>".html_safe
          #Create link to cancel invitation
        end
      end
    elsif
      friendship = Friendship.find_by(user_id: friend.id, friend_id: current_user.id)
      if friendship.status == true
        # rubocop:disable Metrics/LineLength
        #(link_to 'Add Friend!', remove_attendances_path(id: event.id), method: :post).to_s.html_safe
        "<p>You are Friends</p>".html_safe
        #Create remove friend link
      else
        #(link_to 'Unfriend!', join_attendances_path(id: event.id), method: :delete).to_s.html_safe
        # rubocop:enable Metrics/LineLength
        if friendship.friend_id == current_user.id
          "<p>Accept</p>".html_safe
        else
          "<p>Pending</p>".html_safe
        end
      end
    else
      if current_user.id != friend.id
        "<p>Add Friend</p>".html_safe
        #Create add friend link
      end
    end
  end
end
