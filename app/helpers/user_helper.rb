# frozen_string_literal: true

module UserHelper
  def added_friend(user, friendship)
    if current_user.id == user.id || current_user.sent_to_friend?(user) || user.sent_to_friend?(current_user)
      return
    end

    render 'invite_button', user: user,
                            friendship: friendship
  end

  def rec_invites(user, invite)
    if current_user.id == user.id
      render 'posts/received_invites', received_invites: invite
      end
  end
end
