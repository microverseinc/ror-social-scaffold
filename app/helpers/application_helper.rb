module ApplicationHelper
  def sign_out_btn
    link_to 'Sign out', destroy_user_session_path, method: :delete if current_user
  end

  def sign_in_btn
    link_to 'Sign in', user_session_path unless current_user
  end

  def notice_con1
    return unless notice.present?

    "<div class='notice'>".html_safe
  end

  def notice_con
    notice if notice.present?
  end

  def alert_con
    alert if alert.present?
  end

  def alert_con1
    return unless alert.present?

    "<div class='alert'>".html_safe
  end

  def closing_div
    '</div>'.html_safe
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

  def friend_or_unfriend_btn(user)
    @check = Friendship.where(user_id: user.id).where(friend_id: current_user.id).first
    return unless user.id != current_user.id && !@friends && !@check && !user.friends.include?(current_user)

    friend = Friendship.where(user_id: current_user.id).where(friend_id: user.id).where(confirmed: nil).first
    if friend
      link_to('Cancel request', friendship_path(friend), class: 'btn btn-outline-danger btn-sm ml-3', method: :delete)

    else
      link_to('Add friend', friendships_path(user), class: 'btn btn-outline-success btn-sm ml-3', method: :post)
    end
  end

  def unfriend_btn(user)
    friend = Friendship.where(user_id: [current_user.id,
                                        user.id]).where(friend_id: [current_user.id,
                                                                    user.id]).where(confirmed: true).first
    link_to('Unfriend', friendship_path(friend), class: 'btn btn-outline-danger btn-sm ml-3', method: :delete)
  end

  def decline_btn(user, current)
    return unless current_user.id == current.id

    friend = Friendship.where(user_id: user.id).where(friend_id: current_user.id).first
    link_to('Cancel', friendship_path(friend), class: 'btn btn-outline-danger btn-sm ml-3', method: :delete)
  end

  def accept_btn(user, current)
    return unless current_user.id == current.id

    friend = Friendship.where(user_id: user.id).where(friend_id: current_user.id).first
    link_to('Accept', friendship_path(friend), class: 'btn btn-outline-success btn-sm ml-3', method: :patch)
  end

  def pending_header(user)
    return unless current_user.id == user.id && @pending.any?

    '<h3>Pending request</h3>'.html_safe
  end

  def pending_name(user, name)
    return unless user.id == current_user.id

    name.name
  end

  def sent_header(user)
    return unless current_user.id == user.id && @sent.any?

    '<h3>Sent request</h3>'.html_safe
  end

  def sent_names(user, name)
    return unless current_user.id == user.id && @sent.any?

    name.name
  end

  def sent_button(user, new1)
    return unless current_user.id == user.id

    friend_or_unfriend_btn(new1)
  end

  def user_page_btn
    return unless current_user

    (menu_link_to "#{current_user.name}'s page", user_path(current_user)).html_safe
  end
end
