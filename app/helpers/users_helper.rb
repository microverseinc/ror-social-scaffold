module UsersHelper
  def gravatar_for(user)
    link_to image_tag(user.gravatar_url), user_path(user)
  end

  def check_relationship(user, other_user, form)

    p other_user

    message = 'friend' if user.friend?(other_user)
    message = 'pending friend request' if user.pending?(other_user)
    message = 'send friend request'

    return nil if message == 'friend'

    form.submit message
  end
end
