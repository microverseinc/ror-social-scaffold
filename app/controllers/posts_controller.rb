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
    users = [current_user.id]
    unless Friendship.find_by(sender_id: current_user.id, status: true).nil?
      users << Friendship.find_by(sender_id: current_user.id, status: true).reciever_id
    end
    unless Friendship.find_by(reciever_id: current_user.id, status: true).nil?
      users << Friendship.find_by(reciever_id: current_user.id, status: true).sender_id
    end

    @timeline_posts ||= Post.all.ordered_by_most_recent.where('user_id IN (?)', users)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
