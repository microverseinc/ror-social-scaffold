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

  def friend_status(user)
    if current_user.friend?(user)
      link_to 'Unfriend', destroy_friendship_path(user.id), class: 'btn bg-danger btn-sm text-light'
    elsif current_user.pending_friends.include?(user)
      link_to 'Cancel friendship request', destroy_friendship_path(user.id), class: 'btn bg-warning btn-sm text-light'
    elsif current_user.friendship_requests.include?(user)
      render 'accept_reject', locals: { friend_id: user.id }
    else
      link_to 'Add to friendlist', send_request_path(user.id), class: 'btn bg-info btn-sm text-light'
    end
  end
end
