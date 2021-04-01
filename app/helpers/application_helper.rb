module ApplicationHelper
  def friend?(user); end

  def already_sended?(user)
    return unless current_user.friendships.any? { |friendship| friendship.friend == user }

    redirect_to root_path
    flash[:notice] = 'you already sent a request to this person'
  end

  def sended_to_us?(_user)
    return unless current_user.inverse_friendships.any? { |friendship| friendship.user == current_user }

    redirect_to root_path
    flash[:notice] = 'this person already sent a request to you'
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

  def btn_send(user)
    return unless current_user.friendships.none? { |friendship| friendship.friend == user }

    (link_to 'Send request', user_friendships_path(user), method: :post)
  end
end
