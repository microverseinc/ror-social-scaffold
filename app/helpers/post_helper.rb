module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def friend_post(posts)
    approved = []
    posts.each do |post|
      if friendship_exist?(post.user.id,
                           current_user.id) && status?(post.user.id, current_user.id) || post.user.id == current_user.id
        approved << post
      end
    end
    render partial: 'post', collection: approved
  end
end
