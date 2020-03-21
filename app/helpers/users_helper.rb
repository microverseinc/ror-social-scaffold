module UsersHelper
  def gravatar_for(user)
    link_to image_tag(user.gravatar_url), user_path(user)
  end

  def check_relationship(user, other_user, form)
    return nil if user == other_user

    message = 'see friend request' if other_user.pending?(user)
    message = 'already friend' if user.friend?(other_user)
    message = 'pending friend request' if user.pending?(other_user)
    message ||= 'send friend request'

    form.submit message, disabled: ['already friend', 'pending friend request'].include?(message)
  end
end
