class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where('id != ?', current_user.id).all
  end

  def show
    @pending_friendships = current_user.inverse_friendships
    @sent_friendships = current_user.friendships.unconfirmed

    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent

    @inverse_friends = current_user.inverse_friendships.confirmed.map(&:user)
    @friends = current_user.friendships.confirmed.map(&:friend)
    @comments = Comment.all
  end
end
