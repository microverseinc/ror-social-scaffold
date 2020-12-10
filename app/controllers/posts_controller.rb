class PostsController < ApplicationController
  include ApplicationHelper
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
    friends_id = all_friends.map(&:id)
    all_ids = friends_id + [current_user.id]
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user).where(user_id: all_ids)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
