class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    store_location
    @post = Post.new
    fetch_timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:success] = 'Post was successfully created.'
      redirect_to posts_path
    else
      fetch_timeline_posts
      flash[:danger] = 'Post was not created.'
      render :index
    end
  end

  private

  def fetch_timeline_posts
    @timeline_posts ||= current_user.timeline_posts.paginate(page: params[:page])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
