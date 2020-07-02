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
    @timeline_posts ||= friend_posts.ordered_by_most_recent
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def friend_posts
    friends = current_user.friends
    Post.where(user_id: friends.each(&:id)).or(Post.where(user_id: current_user.id))
  end
end
