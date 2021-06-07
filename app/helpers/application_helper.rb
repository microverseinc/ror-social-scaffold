# rubocop:disable Layout/LineLength
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

  def owner_or_friend?(user)
    current_user.id == user.id || current_user.friend?(user)
  end

  def owner?(user)
    current_user.id == user.id
  end

  def friend_requests_button(user)
    return if owner?(user)

    if current_user.friend?(user)
      render html: '<span class="btn btn-success"> <i class="fas fa-thumbs-up"></i> Friendship confirmed </span>'.html_safe

    elsif current_user.pending_friendship?(user)
      # render html: '<button type="button" class="btn btn-warning"><i class="fas fa-heartbeat"></i><span> Pending </span></button>'.html_safe
      link_to('Pending', user_path(current_user), class: 'btn btn-warning fas fa-heartbeat')
    else
      link_to('Add Friend', user_friendships_path(user_id: user.id), method: :post, class: 'friendship_btn')
    end
  end

  def accept_friendship(friendship)
    actual_user = User.find_by(id: params[:id])
    return unless current_user == actual_user

    link_to('Accept', user_friendship_path(friendship.user, friendship.id), method: :put, class: 'friendship_btn')
  end

  def reject_friendship(friendship)
    actual_user = User.find_by(id: params[:id])
    return unless current_user == actual_user

    link_to('Reject', user_friendship_path(friendship.user, friendship.id), method: :delete, class: 'friendship_btn_2')
  end
end
# rubocop:enable Layout/LineLength
