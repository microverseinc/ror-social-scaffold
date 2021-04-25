class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @sent_invites = Friendship.where(user_id: current_user.id)
    @received_invites = Friendship.where(friend_id: current_user.id)
    @blank_friendship = Friendship.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)
    @sent_invites = Friendship.where(user_id: current_user.id)
    @received_invites = Friendship.where(friend_id: current_user.id)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts = current_user.posts.ordered_by_most_recent.includes(:user)
    @timeline_posts += current_user.mutual_friends.map do |friend|
      friend.posts.ordered_by_most_recent.includes(:user) if current_user.confirmed_friend?(friend)
    end
    @timeline_posts.flatten!
    @timeline_posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
