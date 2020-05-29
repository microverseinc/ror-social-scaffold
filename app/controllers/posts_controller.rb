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
    reqd_ids = current_user.requested_friends
      .includes(:sent_friendships)
      .where('friendships.status = true').pluck('id')
    # reqing_ids = current_user.requesting_friends
    #   .includes(:sent_friendships)
    #   .where('friendships.status = true').pluck('id')
    posts_filter = reqd_ids.push(current_user.id)
    # posts_filter = (reqd_ids + reqing_ids).push(current_user.id)
    @timeline_posts ||= Post.where("user_id IN (#{posts_filter.join(', ')})").ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
