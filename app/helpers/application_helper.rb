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
    if !user.friends.empty?
      result = ''
      user.friends.each do |friend|
        result += "<div class='mb-2'><li>#{friend.name}</li></div>"
      end
    end
    result.html_safe
  end
end

def show_attendees(attendees)
  result = '<p>No attendees yet</p>'
  unless attendees.count.zero?
    result = ''
    attendees.each do |attendee|
      result += "<div style='background-color: beige' class='rounded p-1 mb-1'>#{attendee.name}</div>"
    end
  end
  result.html_safe
end

