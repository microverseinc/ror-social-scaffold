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

  def posts
    render json: Post.all
  end

  private

  def timeline_posts
    @timeline_posts = []
    Post.all.ordered_by_most_recent.each do |post|
      @timeline_posts << post if post.user_id == current_user.id
      current_user.friends.each do |i|
        @timeline_posts << post if post.user_id == i.id
      end
    end
    @timeline_posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
