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

  def match_str?(str1, str2)
    return false unless str1.is_a?(String)

    str1.match(str2)
  end

  def connection_links?(user)
    return button_to 'Add Friend', friendships_path(id: user.id), method: :post, class: 'blue-700' unless user.status

    return content_tag(:div, 'friend', class: 'blue-500') if user.status.eql? 'connected'

    if user.id.eql? user.friend_id
      return button_to 'Requested', friendship_path(id: user.user_id, friend_id: user.friend_id, act: 'rollback'),
                       method: :put, class: 'blue-200', data: { confirm: 'Cancel Request' }
    end
    concat button_to 'Accept', friendship_path(id: user.user_id, friend_id: user.friend_id, act: 'accept'),
                     method: :put, class: 'green-500'
    button_to 'Reject', friendship_path(id: user.user_id, friend_id: user.friend_id, act: 'reject'),
              method: :put, class: 'gray-300'
  end
end
