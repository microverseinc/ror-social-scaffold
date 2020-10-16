module UsersHelper
  def confirm_button(friend)
    return unless current_user.friend_requests

    (link_to 'Accept', add_friend_user_path(friend), method: :put, class: 'accept btn btn-secondary profile-link') <<
      (link_to 'Reject', unfriend_user_path(friend), method: :delete, class: 'reject btn btn-secondary profile-link')
  end

  def confirm_friendship_button(user)
    if current_user.friend_requests.any?(user)
      confirm_button(user)
    else
      friendship_button(user)
    end
  end

  def friendship_button_show(friend)
    if current_user != @user && current_user.friend_requests.none?(@user)
      friendship_button(friend)
    elsif current_user.friend_requests.any?(@user)
      confirm_button(friend)
    end
  end
end
