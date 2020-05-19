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

  def friends(user)
    a = Friendship.where(user_id: current_user.id, friend_id: user, confirmed: true)
    b = Friendship.where(user_id: user, friend_id: current_user.id, confirmed: true)
    user if a.exists? || b.exists? || user == current_user.id
  end

  def timeline_posts
    @timeline_posts = []
    @all = Post.all.ordered_by_most_recent.includes(:user)
    @all.each do |v|
      @timeline_posts.push(v) if v.user_id == friends(v.user_id)
    end
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
