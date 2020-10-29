module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def custom_timeline
    friends = current_user.friends
    friends_posts = []
    if friends.empty?
      friends_posts << current_user.posts
    else
      friends.each do |friend|
        user_finder = User.find(friend.id)
        friends_posts << user_finder.posts + current_user.posts
      end
    end
    friends_posts
  end

  def sorted_custom_timeline
    custom_timeline.each do |post|
      post.sort_by(&:created_at).reverse!
    end
  end
end
