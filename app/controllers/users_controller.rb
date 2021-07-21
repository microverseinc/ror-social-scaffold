class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def new
    @request = Friendship.new
    create
  end

  def create
    @request = Friendship.create(friendship_params)
    if @request.save
      redirect_to root_path, notice: 'Friendship request sent!'
    else
      redirect_to users_path
    end
  end

  private

  def friendship_requests
    Friendship.where(friend_id: current_user.id, confirmed: false)
  end

  def friendship_params
    params.permit(:user_id, :friend_id, :confirmed)
  end
end
