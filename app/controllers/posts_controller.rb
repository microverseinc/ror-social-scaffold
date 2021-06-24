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
    ids = []
    # returns ids of accepted friends of currently logged in user
    current_user.friendships.each { |f| ids << f.friend_id if f.status == true }
    @timeline_posts = []
    # add id of currently logged in user to ids array
    ids << current_user.id
    # returns posts of currently logged in user and their friends
    i = 0
    while i < ids.length
      @timeline_posts += Post.where('user_id = ?', ids[i])
      i += 1
    end
    @timeline_posts.reverse!
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
