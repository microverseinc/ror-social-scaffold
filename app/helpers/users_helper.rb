module UsersHelper
  def friendship_button(user)
    if current_user.friend?(user)
      'already friends'
    elsif current_user.demanding?(user)
      'awaiting response'
    elsif current_user.friendship_requested?(user)
      render partial: 'users/respond_to_invite', locals: { user: user }
    else
      render partial: 'users/invite_friend', locals: { user: user }
    end
  end
end
