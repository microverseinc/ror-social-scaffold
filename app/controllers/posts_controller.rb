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
    all_my_friends = []
    
    current_user.friendships.each do |c|
      all_my_friends << c.friend_id
    end
    
    Friendship.all.each do |c|
      
      if c.friend_id == current_user.id
        all_my_friends << c.user_id
      end

    end
    @timeline_posts ||= Post.where(user_id: all_my_friends).ordered_by_most_recent
  end

  def post_params
    params.require(:post).permit(:content)
  end
end