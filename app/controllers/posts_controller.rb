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

  def friends_list
    list = []
    Friendship.where(friend_id: current_user.id).each { |f| list << User.find_by_id(f.user_id) }
    Friendship.where(user_id: current_user.id).each { |f| list << User.find_by_id(f.friend_id) }
    list
  end

  def timeline_posts
    @friends = friends_list
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
