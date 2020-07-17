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
    a = current_user.friend_requests.exists?(user_id: current_user.id, friend_id: id)
    b = User.find(id).friend_requests.exists?(user_id: id, friend_id: current_user.id)
    a || b
  end

  def current_user_requests(id)
    current_user.friend_requests.exists?(user_id: current_user.id, friend_id: id)
  end

  def pending_requests(id)
    request = current_user.friend_requests.find_by(friend_id: id)
    request_two = current_user.friends.find_by(user_id: id)

    if request.nil?
      request_two.confirmed
    else
      request.confirmed
    end
  end

  def pending_invitations
    current_user.friends.map { |frnd| frnd.user unless frnd.confirmed }.compact
  end

  def current_user_and_friends_posts
    pp current_user.friend_requests.where(confirmed: true).class
    # current_user_and_friends = frnds + [current_user]
    # pp current_user_and_friends.map { |user| user.posts }.compact.flatten.class
  end
end
