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

  def new_friendship_button(user)
    unless user.friendships.exists?(user_id: current_user.id)
      (link_to 'Attend Event', new_friendship_path(id: user.id, confirmed: true), class: 'button is-primary', method: :post).to_s.html_safe
    else
      '<p>You already signed up for this event</p>'.html_safe
    end
  end
end
