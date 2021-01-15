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

  def friendship_action(friend)
    return if friend == current_user

    friendship = current_user.friendships.find_by(friend: friend)
    friendship ||= current_user.inverse_friendships.find_by(user: friend)

    if friendship.nil?
      params = { 'friendship[friend_id]': friend.id }
      button_to('Add friend', user_friendships_path(current_user), params: params, form_class: 'inline-form')
    else
      friendship_button(friendship)
    end
  end

  private

  def friendship_button(friendship)
    case friendship.status
    when 'pending'
      button_to('Cancel Request', user_friendship_path(current_user, friendship),
                method: :delete, class: 'btn btn-warning', form_class: 'inline-form',
                data: { confirm: 'Cancel friend request?' })
    when 'confirmed'
      button_to('Remove Friend', user_friendship_path(current_user, friendship),
                method: :delete, class: 'btn btn-danger', form_class: 'inline-form',
                data: { confirm: 'Delete friend?' })
    end
  end
end
