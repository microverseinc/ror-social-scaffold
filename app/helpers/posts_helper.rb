module PostsHelper
  def full_messages
    render 'posts_errors' if @post.errors.full_messages.any?
  end
end
