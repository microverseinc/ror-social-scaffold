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

  def sent_requests(id)
    a = FriendRequest.exists?(user_id: current_user.id, friend_id: id)
    b = FriendRequest.exists?(user_id: id, friend_id: current_user.id)
    a || b
  end

  def current_user_requests(id)
    FriendRequest.exists?(user_id: current_user.id, friend_id: id)
  end

  def pending_requests(id)
    request = FriendRequest.find_by(user_id: current_user.id, friend_id: id)
    request_two = FriendRequest.find_by(user_id: id, friend_id: current_user.id)

    request.nil? ? request_two.confirmed : request.confirmed
  end

  def pending_invitations
    FriendRequest.where(friend_id: current_user.id).map { |frnd| frnd.user unless frnd.confirmed }.compact
  end
end
