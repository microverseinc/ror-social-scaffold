module UserHelper
  def friend_button(_current_user, user)
    if @my_friends.include?(user) || @pending_requests.include?(user) || @requested_friends.include?(user)
      ''
    else
      link_to 'Send Friend Request', add_friend_path(user), method: :post, class: 'btn btn-primary'
    end
  end
end
