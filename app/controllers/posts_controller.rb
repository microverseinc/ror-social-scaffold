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
    friends_posts = current_user.posts
    current_user.friends.each do |friend|
      friends_posts += friend.posts
    end
    @timeline_posts = friends_posts.sort { |a, b| b.updated_at <=> a.updated_at }
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
