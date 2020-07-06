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

  def current_user_friend(user)
    link_to 'unfriend', user_remove_path(user), method: :delete, class: 'profile-link' if current_user.friend?(user)
  end

  def pending(user)
    if current_user.pending_friends.include?(user) # rubocop:disable Style/GuardClause
      link_to ' cancel friend request ', user_cancel_path(friend_id: user.id, user_id: current_user.id), class: 'profile-link', method: :delete # rubocop:disable Metrics/LineLength: Line is too long
    end
  end

  def pending1(user)
    if current_user.pending_friends.include?(user) # rubocop:disable Style/GuardClause
      link_to ' your friend request is pending ', user_path(user), class: 'profile-link'
    end
  end

  def friend_request1(user)
    if current_user.friend_requests.include?(user) # rubocop:disable Style/GuardClause
      link_to user.name + ' sent a friend request ', user_path(user), class: 'profile-link'
    end
  end

  def friend_request2(user)
    if current_user.friend_requests.include?(user) # rubocop:disable Style/GuardClause
      link_to 'Accept ', user_accept_path(user), class: 'profile-link', method: :post
    end
  end

  def friend_request3(user)
    if current_user.friend_requests.include?(user) # rubocop:disable Style/GuardClause
      link_to ' or Reject', user_reject_path(user), class: 'profile-link', method: :delete
    end
  end

  def add_friend(user)
    if !current_user.friend?(user) && !current_user.pending_friends.include?(user) && !current_user.friend_requests.include?(user) # rubocop:disable Metrics/LineLength, Style/GuardClause
      link_to 'add friend', user_invite_path(friend_id: user.id, user_id: current_user.id), method: :post, class: 'profile-link' # rubocop:disable Metrics/LineLength: Line is too long
    end
  end
end
