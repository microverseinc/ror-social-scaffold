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

  def index_links
    out = ''
    out += if user_signed_in?
             "<p>#{link_to(current_user.name, posts_path)}</p>"
           else
             "<p>#{link_to('Timeline', posts_path)}</p>"
           end
    out.html_safe
  end

  def users_links
    out = ''
    out += if user_signed_in?
             "<p>#{link_to('Sign Out', destroy_user_session_path, method: :delete)}</p>"
           else
             "<p>#{link_to('Sign In', user_session_path)}</p>"
           end
    out.html_safe
  end

  def alerts
    out = ''
    out += "<div class=\"notice\"><p>#{notice}</p></div>" if notice.present?
    out += "<div class=\"alert\"><p>#{alert}</p></div>" if alert.present?
    out.html_safe
  end
end
