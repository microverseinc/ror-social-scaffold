module UsersHelper
  def accept_or_pending_btn(user)
    return unless current_user.id != user.id

    return if current_user.friend?(user)

    out = ''
    if current_user.sent_request.include?(user)
      out << link_to('You already sent a request')
    elsif current_user.friend?(user)
      out << link_to('You are already friends')
    elsif current_user.pending_request.include?(user)
      out << link_to('Accept Request', add_friend_path(friend_id: user.id), method: :put, id: 'accept_request')
      out << ' | '
      out << link_to('Reject Request', remove_friend_path(friend_id: user.id), method: :delete, id: 'reject_request')
    else
      out << link_to('Add Friend', friendships_path(user_id: user.id), method: :post, id: 'add_friend')
    end

    out.html_safe
  end
end
