class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    timeline_posts
    @post = Post.new
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
    all_posts = Post.where(user: current_user.friends)
    all_posts += current_user.posts
    @timeline_posts ||= all_posts.sort { |a, b| b.created_at <=> a.created_at }
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
