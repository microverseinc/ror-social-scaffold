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
    friends_list = Friendship.list_of_friends_ids(current_user)
    @timeline_posts ||= Post.all.ordered_by_most_recent.where(user_id: friends_list).includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
