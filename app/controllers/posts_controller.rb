class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:success] = 'Post was successfully created.'
      redirect_to posts_path
    else
      timeline_posts
      flash[:danger] = 'Post was not created.'
      render :index
    end
  end

  private

  def timeline_posts
    friends_ids = current_user.friends.map(&:id)
    @timeline_posts = Post.where('user_id IN (?) OR user_id = ? ',
                                 friends_ids, current_user.id).paginate(page: params[:page])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
