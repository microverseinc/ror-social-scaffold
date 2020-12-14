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

  def friendship_status_link(user)
    if current_user.friends.include?(user)
      '&#128101 Already friends'.html_safe
    elsif current_user.recieved_requests.include?(user)
      "<span> request recieved <br/></span> \n
      #{link_to 'Reject', reject_request_path(user), class: 'reject-link'}
      #{link_to 'Accept', accept_friend_path(user), class: 'accept-link'} ".html_safe
    elsif current_user.sent_requests.include?(user)
      '<button class="sent-request">Friend request sent</button>'.html_safe
    else
      unless current_user.relation_exist?(user)
        (link_to 'Invite to friendship', friend_request_path(user), class: 'invite-link')
      end
    end
  end
end
