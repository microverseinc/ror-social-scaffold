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
    @my_posts = current_user.posts
    @friends = Friendship.where(user_id: current_user.id, confirmed: true)
    
    @my_friends_posts = []
    @friends.each do |friendship|
      user = User.find_by(id: friendship.friend_id)
      @my_friends_posts << user.posts
    end
    @friends = Friendship.where(friend_id: current_user.id, confirmed: true)
    @friends.each do |friendship|
      user = User.find_by(id: friendship.user_id)
      @my_friends_posts << user.posts
    end

    @timeline_posts = @my_posts + @my_friends_posts
    
    @timeline_posts.compact
    # debugger
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
