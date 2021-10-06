class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new

    respond_to do |format|
      format.html { timeline_posts }
      format.xml { render xml: timeline_posts }
      format.json { render json: timeline_posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.json { render json: @post }
    end
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
    @timeline_posts = Post.where(user: (current_user.friends.to_a << current_user)).ordered_by_most_recent
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
