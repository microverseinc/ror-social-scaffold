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

  def friend_request_link(user)
    if !current_user.friends.include?(user) && !user.friend_requests.include?(current_user) && current_user != user && !current_user.friend_requests.include?(user) # rubocop:disable Style/GuardClause
      link_to 'Send Friend Request', user_create_friend_request_path({ user_id: current_user.id, friend_id: user.id }), class: 'link-btn' # rubocop:disable Layout/LineLength
    end
  end

  def actual_user
    current_user == @user
  end

  def render_friends
    render 'friends' if actual_user
  end
end
