class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json, :html, :js

  def index
    @users = User.all
    render json: [current_user]
    @not_my_request = current_user.pending_friends
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @requests = current_user.friend_requests
    @are_we_friends = current_user.are_we_friends?(params[:id], current_user.id)
    @friend_request = current_user.friendship_request?(params[:id], current_user)
    @pending_friend = current_user.pending_friends?(params[:id], current_user)
    @my_friendship = current_user.my_friendship(params[:id], current_user)
    @my_request = current_user.my_request(params[:id], current_user)
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
