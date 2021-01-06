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

  def flash_notice
    if flash[:notice]
      raw("<div class='notification is-primary global-notification mb-0'>
        <p class='notice'>#{notice}</p>
      </div>")
    end
  end

  def flash_alert
    if flash[:alert]
      raw("<div class='notification is-danger global-notification mb-0'>
        <p class='alert'>#{alert}</p>
    </div>")
    end
  end

  def nav_bar
    if user_signed_in?
      raw(" <p class='logged'> Logged in as:<br> #{current_user.name}</p>
      #{link_to 'Sign out', destroy_user_session_path, method: :delete} ")
    else
      link_to 'Sign in', user_session_path

    end
  end
end
