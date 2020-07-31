module UserPostsHelper
  def render_user_posts
    if signed_in? && Friendship.reacted?(current_user.id, @user.id)
      render @posts
    elsif signed_in? && @user == current_user
      render @user.posts.order(created_at: :desc)
    end
  end
end
