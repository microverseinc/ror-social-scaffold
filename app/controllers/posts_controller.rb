class PostsController < ApplicationController
  before_action :authenticate_user!
  # before_action

  def index
    @post = Post.new
    @timeline_posts = timeline_posts(current_user.friends)
  end

  def create
    @post = current_user.posts.new(post_params)

    redirect_to posts_path, notice: 'Post was successfully created.' if @post.save
  end

  private

  def timeline_posts(list_of_friends)
    timeline_posts = Post.all.user_posts(current_user)
    list_of_friends.each do |friend|
      timeline_posts += Post.all.user_posts(friend)
    end
    timeline_posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
end

# Before showing post
# => Check if user is friend of Author's post
# => if true then show the posts
# => else, don't show the post
