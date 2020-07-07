class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    user_with_posts_to_show = current_user.friends
    user_with_posts_to_show << current_user
    @timeline_posts = Post.timeline(user_with_posts_to_show)
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
