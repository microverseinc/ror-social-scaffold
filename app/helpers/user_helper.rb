module UserHelper
  def request_control(obj)
    return unless current_user.id != obj.id

    return if current_user.friend?(obj)

    foo = ''
    if current_user.pending_friends.include?(obj)
      foo << link_to('Acceptance: Invite sent', '#')
    elsif current_user.friend_requests.include?(obj)
      foo << link_to('Approve', invite_path(user_id: obj.id), method: :put)
      foo << ' | '
      foo << link_to('Decline', reject_path(user_id: obj.id), method: :delete)
    else
      foo << link_to('Add Friend', invite_path(user_id: obj.id), method: :post)
    end

    foo.html_safe
  end
end
