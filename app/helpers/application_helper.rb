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

  def current_user_or_friend?(user)
    current_user == user || current_user.friend?(user)
  end

  # def accept_friendship(friendship)
  #   return unless current_user == @user
  #   link_to('Accept', user_friendship_path(friendship.user, friendship.id), method: :put, class: 'profile-link')
  # end

  def add_friend_request_btn(user)
    return if current_user == user || user.friend?(current_user)
    return if current_user.friend_requests.include?(user)

    if current_user.pending_friends.include?(user)
      content_tag(:h6, class: 'ms-2') do
        concat content_tag(:span, 'Pending', class: 'badge bg-secondary ms-2')
      end
    else
      link_to('Add friend', user_friendships_url(user), method: :post, class: 'btn btn-secondary ms-2')
    end
  end

  def accept_friend_request_btn(user)
    return if current_user == user || current_user.pending_friends.include?(user) || user.friend?(current_user)

    return unless current_user.friend_requests.include?(user)

    link_to('Accept', user_friendship_path(user, current_user), method: :put,
                                                                class: 'btn btn-secondary ms-2') +
      link_to('Reject', user_friendship_path(user, current_user), method: :delete,
                                                                  class: 'btn btn-secondary ms-2')
  end
end
