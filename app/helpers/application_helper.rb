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

  def friends_names(user)
    result = 'You currently have:'
    unless user.friends.empty?
      result = ''
      user.friends.each do |friend|
        result += friend.name.to_s
      end
    end
    result.html_safe
  end

  def pending_requests(user)
    result = 'You have no friends. How about adopting a dog or a cat?'
    unless user.friend_requests.empty?
      result = ''
      user.friend_requests.each do |request|
        result += request.name.to_s
        if user == current_user
          result += (button_to 'Accept', accept_user_path(request.id), method: :get).to_s
          result += (button_to 'Decline', decline_user_path, method: :get, params: { data: request.id }).to_s
        end
        result += ' '
      end
    end
    result.html_safe
  end

  def accept_decline_buttons(user)
    result = ''
    current_user.friend_requests.each do |request|
      if request == user
        result += (button_to 'Accept', accept_user_path(request.id), method: :get).to_s
        result += (button_to 'Decline', decline_user_path(request.id), method: :get).to_s
      end
    end
    result.html_safe
  end

  def invitation_button(user)
    result = ''
    if !user.friends.include?(current_user) && user != current_user && !user.pending?(current_user)
      result += (button_to 'Add Friend', create_friendship_user_path(user.id),
                           method: :get).to_s
    end
    result.html_safe
  end

  def friend(user)
    '<h1>Friend</h1>'.html_safe if user.friends.include?(current_user)
  end

  def pendings(user)
    '<h1>Pending Requests</h1>'.html_safe if user.inverse_friendships.find do |frd|
                                               frd.user_id == current_user.id && !frd.confirmed
                                             end
  end
end
