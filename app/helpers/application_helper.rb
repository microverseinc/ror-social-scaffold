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

  def signin_or_signout
    if signed_in?
      "<p class='mr-3 mb-0'>Logged in as [#{current_user.name}]</p>
      #{link_to 'Sign out', destroy_user_session_path, method: :delete}".html_safe
    else
      link_to('Sign in', user_session_path)
    end
  end

  def show_friends_names(user)
    result = '<b>No friends yet</b>'
    unless user.friends.empty?
      result = ''
      user.friends.each do |friend|
        result += "<div class='mb-2'><li>#{friend.name}</li></div>"
      end
    end
    result.html_safe
  end

  def show_pending_requests(user)
    result = '<b>No friend requests</b>'
    unless user.friend_requests.empty?
      result = ''
      user.friend_requests.each do |req|
        result += "<div class='d-flex align-items-center mb-2'><li>#{req.name}</li>"
        if user == current_user
          result += (button_to 'Accept', accept_user_path(req.id), method: :get, class: 'p-1 ml-2').to_s
          result += (button_to 'Decline', decline_user_path, method: :get, params: { data: req.id },
                                                             class: 'p-1 ml-2 bg-danger').to_s
        end
        result += '</div>'
      end
    end
    result.html_safe
  end

  def show_accept_decline_buttons(user)
    result = ''
    current_user.friend_requests.each do |req|
      if req == user
        result += (button_to 'Accept', accept_user_path(req.id), method: :get, class: 'p-1 ml-2').to_s
        result += (button_to 'Decline', decline_user_path(req.id), method: :get, class: 'p-1 ml-2 bg-danger').to_s
      end
    end
    result.html_safe
  end

  def show_send_invitation_button(user)
    result = ''
    if !user.friends.include?(current_user) && user != current_user && !user.pending?(current_user)
      result += (button_to 'send invitation', create_friendship_user_path(user.id),
                           method: :get).to_s
    end
    result.html_safe
  end

  def show_messages
    result = ''
    result += "<div class='notice'><p> #{notice} </p></div>" if notice.present?
    result += "<div class='notice'><p> #{alert} </p></div>" if alert.present?
    result.html_safe
  end
end
