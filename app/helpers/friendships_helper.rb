module FriendshipsHelper
  def friendship_button(friend)
    if friend.friend_requests.any?(current_user)
      link_to 'Pending request', '#', class: 'profile-link btn btn-secondary'
    elsif !current_user.friend?(friend)
      link_to 'Add friend', request_friendship_user_path(friend.id), method: :post,
                                                                     class: 'profile-link btn btn-secondary'
    end
  end
end
