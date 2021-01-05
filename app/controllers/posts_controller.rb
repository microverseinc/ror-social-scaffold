class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
