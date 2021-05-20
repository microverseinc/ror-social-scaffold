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

  def friend?(user)
    is_friend = current_user.senders.find_by(receiver_id: user.id)
    if is_friend
      if is_friend.status.zero?
        link_to '| Cancel Friendship Request', friendship_path(id: is_friend.id), method: :delete, class: 'profile-link'
      else
        link_to '| Unfriend', friendship_path(id: is_friend.id), method: :delete, class: 'profile-link'
      end
    elsif current_user.id == user.id
      nil
    else
      is_friend = current_user.receivers.find_by(sender_id: user.id)
      if is_friend
        if is_friend.status.zero?
          link_to '| Accept Friendship', accept_friendship_path(id: is_friend.id), method: :put, class: 'profile-link'
        else
          nil
        end
      else
        link_to '| Invite to Friendship', new_friendship_path(receiver_id: user.id), method: :post,
                                                                                     class: 'profile-link'
      end
    end
  end
end
