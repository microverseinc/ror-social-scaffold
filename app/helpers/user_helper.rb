module UserHelper
  def display_errors(user)
    return unless user.errors.full_messages.any?

    content_tag :p, "User could not be created. #{user.errors.full_messages.join('. ')}", class: 'errors'
  end

  def add_friend_button(inviter_id, invitee_id)
    if inviter_id == invitee_id || Friendship.exists?(inviter_id: inviter_id, invitee_id: invitee_id)
      return true
    else
      false
    end
  end

  def user(user)  
    @user = user
  end
end
