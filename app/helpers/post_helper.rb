module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    tag.p("Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors')
  end

  def related_to_me?(login_user, friend)
    login_user.friends_with?(friend) or friend == login_user
  end
end
