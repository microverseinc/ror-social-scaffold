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

  def add_friend(user)
    return unless current_user != user

    if current_user.pending_request_with user
      'Friendship Request'
    elsif current_user.friend?(user)
      link_to('Unfriend', unfriend_path(user_id: user), method: :delete)
    elsif current_user.pending_friend?(user)
      'Pending to confirm friend request'
    else
      link_to('Add friend', user_friendships_path(friend_id: user.id, user_id: current_user), method: :post)
    end
  end
end
