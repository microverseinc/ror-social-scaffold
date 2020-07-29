class PostsController < ApplicationController
  before_action :find_post, except: %i[new create index]
  before_action :authenticate_user!

  def index
    @post = Post.new
    @users = User.all
    @comment = Comment.create
    @user = current_user
    @friends = @user.friends
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.new(post_params)

    @post.user = current_user
    if @post.valid?
      @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new, alert: 'Post was not created.'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :user)
  end
end
