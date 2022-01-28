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

  def login_display
    output = ''
    output << if current_user
                " #{link_to current_user.name, user_path(current_user)} |
      #{link_to gravatar_image_tag(current_user.email, gravatar: { size: 18 },
                                                       alt: current_user.name), user_path(current_user)}
      #{link_to 'Sign out', destroy_user_session_path, method: :delete}"
              else
                link_to 'Sign in', user_session_path.to_s
              end
    output.html_safe
  end

  def notice_alert
    output = ''
    if notice.present?
      output << "
      <div class='notice'>
        <p> #{notice} </p>
      </div>"
    elsif alert.present?
      output << "<div class='alert'>
        <p> #{alert} </p>
      </div>"
    end
    output.html_safe
  end
end
