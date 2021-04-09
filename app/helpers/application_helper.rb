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

  def check_friendship_btn(user)
    if current_user.friend? user
      link_to 'unfriend', user_friendship_path(user_id: user.id, id: current_user.id), class: 'reject-link',
                                                                                       method: :delete
    elsif current_user.pending_friendships.pluck(:user_id, :friend_id).any?([current_user.id, user.id])
      link_to 'cancel request', user_friendship_path(user_id: user.id, id: current_user.id), class: 'reject-link',
                                                                                             method: :delete
    elsif current_user.inverted_friendships.pluck(:user_id, :friend_id).any?([user.id, current_user.id])
      link_to('Confirm', user_friendship_path(user_id: user.id, id: current_user.id), class: 'invite-link',
                                                                                      method: :patch) +
        link_to('Reject', user_friendship_path(user_id: user.id, id: current_user.id), class: 'reject-link',
                                                                                       method: :delete)
    else
      link_to 'Send Friend Request', user_friendships_path(user_id: user.id), class: 'invite-link', method: :post
    end
  end
end
