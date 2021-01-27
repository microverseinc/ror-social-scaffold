module ApplicationHelper
  def logged_in?
    !current_user.nil?
  end

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

  def user_is_logged_in
    if logged_in?
      link_to (gravatar_for current_user), user_path(current_user)
      link_to current_user.name, user_path(current_user), id: 'logo'
    end
  end

  def is_current_user
    if current_user
      link_to 'Sign out', destroy_user_session_path, method: :delete
    else
      link_to 'Sign in', user_session_path
    end
  end
end
