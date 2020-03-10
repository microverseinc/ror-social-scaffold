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
    @logged_user = current_user
    @friends_ids = []
    @logged_user.friends.each do |friend|
      @friends_ids << friend.id
    end
    sql = "user_id = #{@logged_user.id} OR user_id IN (?)", @friends_ids
    @timeline_posts ||= Post.all.where(sql).ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
