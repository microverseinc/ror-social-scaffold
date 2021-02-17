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
    if Friendship.exists?(requestor_id: user,
                          requested_id: friend) && Friendship.exists?(requestor_id: friend,
                                                                      requested_id: user) || user == friend
      render posts
    else
      'Only friends can see posts'
    end
  end
end
