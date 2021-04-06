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

  def assigned_posts
    users_post = []
    friends_post = []
    current_user.posts.map { |post| users_post << post }
    current_user.friendships.map { |friendship| friends_post << friendship.user.post }
    users_post.concat(friends_post)
  end

  def timeline_posts
    # @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
    @timeline_posts ||= current_user.friends_and_own_posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
