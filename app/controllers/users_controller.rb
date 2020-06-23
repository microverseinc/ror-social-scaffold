class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friendship = Friendship.new
    # @friendships = Friendship.where(confirmer_id: current_user.id).or(Friendship.where(requester_id: current_user.id))
  end

  def show
    @user = User.find(current_user.id)
    @show_user = User.find(params[:id])

    @new_friendship = Friendship.new

    @f = Friendship.where(confirmer: @user.id)
    @i = Friendship.find_by(confirmer: @user.id)

    @posts = @show_user.posts.ordered_by_most_recent
    @users = User.all
  end
end
