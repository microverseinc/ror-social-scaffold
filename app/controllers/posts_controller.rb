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
    sent_requests = current_user.sent_requests.pluck(:user_id).to_a
    received_requests = current_user.received_requests.pluck(:friend_id).to_a
    friends = sent_requests & received_requests
    friends.push(current_user[:id])
    @timeline_posts ||= Post.where(user_id: friends).ordered_by_most_recent.includes(:user)
    # @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
