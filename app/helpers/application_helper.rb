module ApplicationHelper
  def friend?(user); end

  def already_sended?(user)
    return unless current_user.pending_friendships.any? { |friendship| friendship.friend_id == user }

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
    return if current_user.pending_friends.include?(user)
    return if current_user.friends.include?(user)
    return if current_user.friend_requests.include?(user)

    (button_to 'Send request', user_friendships_path(user), method: :post)
  end

  def btn_mutual(user)
    return if user.friends.include?(nil)

    mutuals = []
    user.friends.map do |friend|
      current_user.friends.map { |friendd| friendd == friend ? mutuals.push(friend.name) : mutuals }
    end
    mutuals.uniq
  end

  def all_users(user)
    return unless user != current_user

    content_tag(:div) do
      content_tag(:h4, user.name) +
        (link_to 'See Profile', user_path(user)) +
        btn_send(user) +
        btn_mutual(user)
    end
  end

  def user_sessionss
    if current_user
      content_tag(:div) do
        (button_to 'Sign out', destroy_user_session_path, method: :delete)
      end
    else
      (button_to 'Sign in', new_user_session_path) +
        (link_to 'Sign up', new_user_registration_path)
    end
  end

  def notice?
    return unless notice.present?

    content_tag(:div, class: 'notice') do
      notice
    end
  end

  def alert?
    return unless alert.present?

    content_tag(:div, class: 'notice') do
      alert
    end
  end
end
