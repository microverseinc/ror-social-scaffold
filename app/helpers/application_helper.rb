module ApplicationHelper
  def menu_link_to(link_text, link_path, icon)
    class_name = current_page?(link_path) ? 'navbar-item is-active' : 'navbar-item'

    # link_to link_text, link_path,class:class_name
    # content_tag(:a,href: link_path,link_text, class: class_name)
    content_tag :a, href: link_path.to_s, class: class_name do
      fa_icon(icon.to_s, text: link_text.to_s)
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete, class: 'tag is-danger is-rounded')
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post, class: 'tag is-light is-rounded')
    end
  end
end
