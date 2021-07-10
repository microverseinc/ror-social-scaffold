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

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Layout/LineLength
  def friendship_request_button(friend)
    return unless signed_in?

    friendship = Friendship.find_by(user_id: current_user.id, friend_id: friend.id)
    if friendship && friendship.status == true
      remove_friend(friend)
    elsif friendship && friendship.status != true
      if friendship.friend_id == current_user.id
        accept_request(friend)
      else
        cancel_request(friend)
      end
    elsif !friendship
      inverse_check(friend)
    end
  end

  def inverse_check(friend)
    friendship = Friendship.find_by(user_id: friend.id, friend_id: current_user.id)
    if friendship && friendship.status == true
      remove_friend(friend)
    elsif friendship && friendship.status != true
      if friendship.friend_id == current_user.id
        accept_request(friend)
      else
        cancel_request(friend)
      end
    elsif current_user.id != friend.id
      add_friend(friend)
    end
  end

  def accept_request(user)
    # Accepts invitations
    friendship = Friendship.find_by(user_id: user.id, friend_id: current_user.id)
    link_to('Accept',
            user_friendship_accept_path(friendship_id: friendship.id, user_id: friendship.user_id, friend_id: friendship.friend_id), class: 'btn btn-secondary', method: :post)
  end

  def cancel_request(user)
    # Cancel invitations request
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: user.id)
    link_to('Cancel Request',
            user_friendship_path(user_id: friendship.user_id, friend_id: friendship.friend_id, id: friendship.id), class: 'btn btn-warning', method: :delete)
  end

  def add_friend(user)
    # Add a friend
    link_to('Add Friend', user_friendships_path(user_id: current_user.id, friend_id: user.id), class: 'btn btn-primary', method: :post)
  end

  def remove_friend(user)
    # Remove a friend
    friendship = Friendship.find_by(user_id: user.id, friend_id: current_user.id)
    friendship ||= Friendship.find_by(user_id: current_user.id, friend_id: user.id)
    link_to('Remove Friend',
            user_friendship_path(user_id: friendship.user_id, friend_id: friendship.friend_id, id: friendship.id), class: 'btn btn-warning-2', method: :delete)
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Layout/LineLength
end
