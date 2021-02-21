class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendships = Friendship.where('received_friendship_id = ? ', current_user)
      .or(Friendship.where('sent_friendship_id = ?', current_user))

    @sent_friendships = @friendships.where('sent_friendship_id = ?', current_user)
    @received_friendships = @friendships.where('received_friendship_id = ?', current_user)
  end
end
