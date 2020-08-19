class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
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
    users_posts = current_user.posts
    friends_posts = current_user.friends.map { |friend| friend.posts if friend.posts.any? }.compact
    friends_posts = friends_posts.flatten
    @timeline_posts = users_posts + friends_posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
