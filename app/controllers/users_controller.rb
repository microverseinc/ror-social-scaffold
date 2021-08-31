class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friends = Friendship.where('friend_id = ? and confirmed = ?', current_user.id, true)
    @friends.all.map(&:user_id)
    @all_friends = []
    @friends.each { |u| @all_friends << User.find(u.user_id) }
  end
end
