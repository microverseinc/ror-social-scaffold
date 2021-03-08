class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :are_friends?

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def are_friends?(user, friend, posts)
    return 'Only friends can see posts' unless current_user.friends.exists?(friend) || user == friend

    render posts
  end
end
