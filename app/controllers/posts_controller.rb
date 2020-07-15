class PostsController < ApplicationController
  before_action :authenticate_user!
  # before_action

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    redirect_to posts_path, notice: 'Post was successfully created.' if @post.save
  end

  private

  def timeline_posts
    @timeline_posts ||= Post.all.ordered_by_most_recent
  end

  def post_params
    params.require(:post).permit(:content)
  end
end

# Before showing post
# => Check if user is friend of Author's post
# => if true then show the posts
# => else, don't show the post
