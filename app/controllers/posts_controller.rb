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

  # def friends_list
  #   list = User.find(current_user.id).friends
  # end

  def timeline_posts
    @timeline_posts ||= User.find(current_user.id).friends_and_own_posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
