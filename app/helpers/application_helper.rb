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
      link_to(content_tag(:span,
                          'Dislike!',
                          class: 'hidden') + content_tag(:i,
                                                         nil,
                                                         class: ['far fa-thumbs-down likes-comments']),
              post_like_path(id: like.id,
                             post_id: post.id),
              method: :delete,
              class: 'like-link')
    else
      link_to(content_tag(:i,
                          nil,
                          class: ['far fa-thumbs-up likes-comments']) + content_tag(:span,
                                                                                    'Like!',
                                                                                    class: 'hidden'),
              post_likes_path(post_id: post.id),
              method: :post,
              class: 'like-link')
    end
  end

  def show_users
    @users = @users.filter { |user| user.id != current_user.id }
    content_tag :ul, class: 'users-list' do
      @users.collect do |user|
        tag1 = content_tag(:span,
                           link_to(' Profile',
                                   user_path(user),
                                   class: 'profile-link'))
        tag2 = image_tag('usuario.png',
                         size: '40x40',
                         alt: 'placeholder image')
        tag3 = content_tag(:span,
                           user.name,
                           class: 'h2-user')
        concat(content_tag(:li, tag2 + tag3 + tag1 + show_friend_request(user),
                           class: ['user-section all-users']))
      end
    end
  end

  def show_latest_friends
    @users = current_user.latest_friends

    content_tag :ul, class: 'users-list' do
      concat content_tag(:h3, 'Latest Friends', class: 'h3-latest-friends')
      @users.collect do |user|
        tag1 = link_to(user.name, user_path(user), class: 'user-name')
        tag2 = image_tag('usuario.png', size: '40x40', alt: 'placeholder image')
        concat(content_tag(:li, tag2 + tag1, class: ['user-section all-users latest-friends']))
      end
    end
  end

  def show_friend_request(user)
    friend_request = current_user.friend_requests
    pending_friend = user.pending_friends
    friend = current_user.friend?(user)
    friend_request_sent = user.friend_requests

    if friend_request.include?(user) && pending_friend.include?(current_user)
      tag1 = content_tag(:span, 'Accept?', class: 'accept-text')
      tag2 = content_tag(:span, 'Accept friend request', class: 'hidden')
      tag3 = content_tag(:i, nil, class: ['fas fa-check'])
      tag4 = link_to(tag2 + tag3, friendships_update_path(user), class: 'profile-link profile-link-accept')
      tag5 = content_tag(:span, 'Reject friend request', class: 'hidden')
      tag6 = content_tag(:i, nil, class: ['fas fa-times'])
      tag7 = link_to(tag5 + tag6, friendships_destroy_path(user), class: 'profile-link profile-link-reject')
      content_tag(:div, tag1 + content_tag(:div, tag4 + tag7), class: 'accept-container')
    elsif friend
      content_tag(:span, content_tag(:i, nil, class: ['fas fa-user-friends']))
    elsif friend_request_sent.include?(current_user)
      content_tag(:span, ' Request sent', class: 'request-text')
    elsif user.id == current_user.id
    else
      tag8 = content_tag(:i, nil, class: ['fas fa-user-plus'])
      tag9 = content_tag(:span, 'Add as a friend', class: 'hidden')
      content_tag(:span, link_to(tag8 + tag9, friendships_create_path(user), class: 'profile-link'))
    end
  end

  def show_comments(post)
    tag1 = content_tag(:i, nil, class: ['far fa-comment-alt likes-comments'])
    tag2 = content_tag(:span, post.count_comments(post).to_s, class: 'counter comment-counter')
    tag1 + tag2
  end
end
