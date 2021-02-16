module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def user_name
    return current_user.name if user_signed_in?
  end

  def in_or_out
    if current_user
      link_to 'Sign out', destroy_user_session_path, method: :delete
    else
      link_to 'Sign in', user_session_path
    end
  end

  def notice_or_alert
    if flash[:notice]
      render partial: 'shared/notice', notice: flash[:notice]
    elsif flash[:alert]
      render partial: 'shared/alert', alert: flash[:alert]
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
end
