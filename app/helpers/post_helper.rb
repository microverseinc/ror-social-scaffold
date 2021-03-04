module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    tag.p("Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors')
  end
end
