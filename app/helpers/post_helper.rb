module PostHelper
  def not_save_post
    render 'post_not_saved' if @post.errors.full_messages.any?
  end
end
