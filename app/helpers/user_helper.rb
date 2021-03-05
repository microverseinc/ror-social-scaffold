module UserHelper
  def invitation_link(user)
    return if user == current_user

    if current_user.invitation_sent?(user)
      if current_user.friends_with?(user)
        'Connected'
      else
        'Pending'
      end
    else
      button_to 'Invite', invitation_path(receiver: user)
    end
  end
end
