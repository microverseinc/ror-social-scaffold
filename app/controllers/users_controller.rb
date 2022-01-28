class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authorize_request, only: :create
  protect_from_forgery with: :null_session, only: [:create]
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def index
    @users = User.all.where.not(email: current_user.email)
  end

  def profile
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
