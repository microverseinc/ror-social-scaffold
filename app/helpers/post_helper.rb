module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def post_of_friend?(post)
    post.user.friend?(current_user) || post.user == current_user
  end
end
