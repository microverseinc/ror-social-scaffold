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

  def user_friend?(user, friend)
    user == friend ? 'hidden' : ''
  end

  def add_friend(friend)
    friend = User.find_by(id: friend.id)
    user = current_user
    if user.friend?(friend)
      link_to('Dismiss Friendship', user_friendship_path(id: user.confirmed_friendships.find_friendship(friend),
                                                         user_id: user.id, friend_id: friend.id), method: :delete)
    elsif !user.friendships_received(friend).nil?
      link_to('Accept friendship', user_friendships_path(user_id: user.id,
                                                         friend_id: friend.id), method: :post)

    elsif !user.friendships_sent(friend).nil?
      link_to('Cancel request', user_friendship_path(id: user.friendships_sent(friend),
                                                     user_id: user.id, friend_id: friend.id), method: :delete)
    else
      link_to('Request Friendship', user_friendships_path(user_id: user.id,
                                                          friend_id: friend.id), method: :post)
    end
  end
end
