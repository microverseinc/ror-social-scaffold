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
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete, id: 'dislike')
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post, id: 'like')
    end
  end

  def if_notice(notice)
    result = ''
    if notice
      result = content_tag(:div,
                           content_tag(
                             :p, notice
                           ),
                           class: 'alert-warning p-2 d-flex justify-content-center')
    end
    result
  end

  def if_alert(alert)
    result = ''
    if alert
      result = content_tag(:div,
                           content_tag(
                             :p, alert
                           ),
                           class: 'alert-danger p-2 d-flex justify-content-center')
    end
    result
  end
end
