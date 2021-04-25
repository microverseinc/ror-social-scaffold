module UserHelper
  def added_friend(user, friendship)
    return if current_user.id == user.id || current_user.sent_to_friend?(user) || user.sent_to_friend?(current_user)

    render 'invite_button', user: user,
                            friendship: friendship
  end

  def rec_invites(user, invite)
    render 'posts/received_invites', received_invites: invite if current_user.id == user.id
  end
end
