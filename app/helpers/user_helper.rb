module UserHelper
  def display_errors(user)
    return unless user.errors.full_messages.any?

    content_tag :p, "User could not be created. #{user.errors.full_messages.join('. ')}", class: 'errors'
  end

  def add_friend_button(inviter_id, invitee_id)
    return true if Friendship.exists?(inviter_id: inviter_id, invitee_id: invitee_id)
    false
  end
end
