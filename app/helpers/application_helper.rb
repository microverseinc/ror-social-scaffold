module ApplicationHelper
  def menu_link_to(link_text, link_path, link_class)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path, link_class
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete, class: 'like-link')
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post, class: 'like-link')
    end
  end

  def show_users
    @users = @users.filter { |user| user.id != current_user.id }
    content_tag :ul, class: 'users-list' do
      @users.collect do |user|
        tag1 = content_tag(:span, link_to(' See Profile', user_path(user), class: 'profile-link'))
        concat(content_tag(:li, content_tag(:span, user.name) + tag1 + show_friend_request(user)))
      end
    end
  end

  def show_friend_request(user)
    friend_request = current_user.friend_requests
    pending_friend = user.pending_friends
    friend = current_user.friend?(user)
    friend_request_sent = user.friend_requests

    if friend_request.include?(user) && pending_friend.include?(current_user)
      link_to(' Accept friend request',
              friendships_update_path(user),
              class: 'profile-link') + link_to(' Reject friend request',
                                               friendships_destroy_path(user), class: 'profile-link')
    elsif friend
      content_tag(:span, ' Friend', class: 'profile-link')
    elsif friend_request_sent.include?(current_user)
      content_tag(:span, ' Friend request sent', class: 'profile-link')
    elsif user.id == current_user.id
    else
      link_to(' Add as a friend', friendships_create_path(user), class: 'profile-link')
    end
  end
end
