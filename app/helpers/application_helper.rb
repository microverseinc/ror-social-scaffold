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

  def friendship_button(user)
    if current_user.friend? user
      link_to 'Unfriend', friendship_path(user.id), class: 'friendship_btn', method: :delete, remote: true
    elsif current_user.friend_requests_sent.pluck(:user_id, :friend_id).any?([current_user.id, user.id])
      link_to 'Cancel Request', friendship_path(user.id), class: 'friendship_btn', method: :delete, remote: true
    elsif current_user.friend_requests_received.pluck(:user_id, :friend_id).any?([user.id, current_user.id])
      link_to('Accept', friendship_path(user.id), class: 'friendship_btn', method: :patch, remote: true) +
        link_to('Reject', friendship_path(user.id), class: 'friendship_btn', method: :delete, remote: true)
    else
      link_to 'Add Friend', friendships_path(id: user.id), class: 'friendship_btn', method: :post, remote: true
    end
  end
end
